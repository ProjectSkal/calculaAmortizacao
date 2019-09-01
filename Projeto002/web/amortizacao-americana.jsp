<%-- 
    Document   : americana
    Created on : 01/09/2019, 16:35:34
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
            <h2>Sistema de Amortização Americano</h2>
                      
            <p>O Sistema de Amortização Americano é uma forma de pagamento de empréstimos que se caracteriza pelo pagamento apenas dos juros da dívida,
                deixando o valor da dívida constante, que pode ser paga em apenas um único pagamento.</p>

            <p>Esse sistema de amortização tem a vantagem em relação ao sistema de pagamento único, pois nele não há incidência de juros sobre juros.
                Os juros sempre incidem sobre o valor original da dívida. Com isso o devedor pode quitar sua dívida quando quiser.</p>
            
            <p>Tem como desvantagem que o pagamento de juros pode, em tese, ser perpétuo mesmo quando já se pagou o equivalente à dívida em si.
                Para isso, basta que o número de prestações exceda 100% quando da soma dos juros simples.</p>
            <hr/>
            <%
                int p = 0;
                try {
                    p = Integer.parseInt(request.getParameter("p"));
                } catch (Exception e) {
                }
                float v = 0;
                try {
                    v = Float.parseFloat(request.getParameter("v"));
                } catch (Exception e) {
                }
                float j = 0;
                try {
                    j = Float.parseFloat(request.getParameter("j"));
                } catch (Exception e) {
                }
                DecimalFormat cv = new DecimalFormat("#0.00");
                DecimalFormat cj = new DecimalFormat("#0.00");
            %>
            <div class="fundo container">
                <br/>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="p" class="col-sm-2 control-label">Período(meses)</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="number" name="p" placeholder="ex: 12"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="v" class="col-sm-2 control-label">Valor $</label>
                        <div class="col-sm-2">
                            <div class="input-group">
                                <input class="form-control" type="number" step="0.01" name="v" placeholder="ex: 12000,67"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="j" class="col-sm-2 control-label">Juros(%a.m.)</label>
                        <div class="col-sm-2">
                                <input class="form-control" type="number" step="0.01" name="j" placeholder="ex: 12,5"/>
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
                <h2>Tabela de Cálculo:</h2>
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table">
                            <tr>
                                <th>Mês</th>
                                <th>Saldo Devedor (R$)</th>
                                <th>Amortização (R$)</th>
                                <th>Juros (R$)</th>
                            </tr>
                            <%for (int i = 0; i <= p; i++) {%>
                            <tr>
                                <td><%=i%></td>
                                <%if (i == p) {
                                        out.println("<td>" + cv.format(0) + "</td>");
                                    } else {
                                        out.println("<td>" + cv.format(v) + "</td>");
                                    }%>
                                <%if (i == p) {
                                        out.println("<td>" + cv.format(v) + "</td>");
                                    } else {
                                        out.println("<td>" + cv.format(0) + "</td>");
                                    }%>
                                <%if (i != 0) {
                                        out.println("<td>" + cj.format(v * j * 0.01) + "</td>");
                                    } else {
                                        out.println("<td>" + cj.format(0) + "</td>");
                                    }%>                
                            </tr>
                            <%}%>
                        </table>
                    </div>
                    <div class="col-sm-4">
                        <span><h4>Total de juros é: R$ <%=cj.format(p * v * j * 0.01)%></h4></span>
                        <span><h4>Total a pagar é:  R$ <%=cv.format((p * v * j * 0.01) + v)%></h4></span>
                    </div>
                </div>
            </div>
        </div>
    <%@include file="WEB-INF/jspf/folder.jspf" %>
    </body>
</html>
