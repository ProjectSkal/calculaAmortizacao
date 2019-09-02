<%-- 
    Document   : amortizacao-constante
    Created on : 01/09/2019, 16:48:42
    Author     : gabriela.s.duarte
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AMORTIZAÇÕES</title>
        <%@include file="WEB-INF/jspf/header.jspf" %>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf"%> <br>
            <h1>Amortização Constante!</h1>
                      
            <p>
                Neste sistema o "saldo devedor"(PV) é reembolsado em valores de amortização iguais. 
                Desta forma, no sistema SAC o valor das prestações(P) é decrescente, já que os juros(J) diminuem a cada prestação. 
                O valor da amortização(A) é calculado, dividindo-se o valor do principal pelo número de períodos de pagamento, 
                ou seja, de parcelas(N). Por sua vez, os juros são calculados sobre o saldo devedor, multiplicando-se a taxa(I) 
                pelo saldo. Finalmente, a soma da amortização e dos juros resultam no valor da parcela.</p>

            <p>O SAC é um dos tipos de sistema de amortização utilizados em financiamentos imobiliários. 
                A principal característica do SAC é que ele amortiza um percentual fixo do valor principal (emissão), 
                desde o início do financiamento. Esse percentual de amortização é sempre o mesmo, o que faz com que a parcela de 
                amortização da dívida seja maior no início do financiamento, fazendo com que o saldo devedor caia mais 
                rapidamente do que em outros mecanismos de amortização.</p>
            
            <p>
                Prestação = Juros + Amortização <br>
                Amortização = Saldo Devedor / Nº de Parcelas
            </p>
            <hr/>
            
            <%
                float divida = 0;
                int parcela = 0;
                float taxa = 0;
                float juros = 0;
                float jurosTotal = 0;
                float totalPago = 0;
                float toalAmortizado = 0;
                float prestacao = 0;                

                try {
                    divida = Float.parseFloat(request.getParameter("divida"));
                    parcela = Integer.parseInt(request.getParameter("parcelas"));
                    taxa = Float.parseFloat(request.getParameter("juros"));                    
                } catch (Exception e) {
                    
                }
                
                taxa = taxa / 100;
                toalAmortizado = divida;
                DecimalFormat decimal = new DecimalFormat("#0.00");                
                float amortizacao = divida / parcela;                
            %>
            <div class="fundo container">
                <br/>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="parcelas" class="col-sm-2 control-label">Período(meses)</label>
                        <div class="col-sm-2">
                            <input class="form-control" id="parcelas" type="number" name="parcelas" placeholder="ex: 12"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="divida" class="col-sm-2 control-label">Valor $</label>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <input class="form-control" type="number" id="divida" step="0.01" name="divida" placeholder="ex: 12000,67"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="juros" class="col-sm-2 control-label">Juros(%a.m.)</label>
                        <div class="col-sm-2">
                                <input class="form-control" type="number" id="juros" step="0.01" name="juros" placeholder="ex: 12,5"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-success">Calcular</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="container">
                <h2>Tabela SAC:</h2>
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table">
                            <tr>
                                <th>Parcela</th>
                                <th>Prestação (R$)</th>
                                <th>Amortização (R$)</th>
                                <th>Juros (R$)</th>
                                <th>Saldo Devedor (R$)</th>
                            </tr>
                            <%for (int i = 0; i <= parcela; i++) {%>
                                <% if (i == 0) { %>
                                    <tr>
                                        <td>0ª</td>
                                        <td>ND</td>
                                        <td>ND</td>
                                        <td>ND</td>
                                        <td><%=decimal.format(divida)%></td>
                                    </tr>
                                <%} else {%>
                                    <% 
                                    juros = divida * taxa;
                                    prestacao = amortizacao + juros;
                                    divida = divida - amortizacao;
                                    jurosTotal = jurosTotal + juros;
                                    totalPago = totalPago + prestacao;
                                    %>
                                    <tr>
                                        <td><%=i%>ª</td>
                                        <td><%=decimal.format(prestacao)%></td>
                                        <td><%=decimal.format(amortizacao)%></td>
                                        <td><%=decimal.format(juros)%></td>                                                      
                                        <td><%=decimal.format(divida)%></td>
                                    </tr>                                    
                                <%}%>                                        
                            <%}%>
                        </table>
                    </div>
                    <div class="col-sm-4">
                        <span><h4>Total de juros é: R$ <%=decimal.format(jurosTotal)%></h4></span>
                        <span><h4>Total pago é:  R$ <%=decimal.format(totalPago)%></h4></span>
                        <span><h4>Total amortizado é:  R$ <%=decimal.format(toalAmortizado)%></h4></span>
                    </div>
                </div>
            </div>
        </div>       
    <%@include file="WEB-INF/jspf/folder.jspf" %>
    </body>
</html>
