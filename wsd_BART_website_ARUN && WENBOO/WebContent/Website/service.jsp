<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dca.tranlist.DomXMLparser"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<%


%>
<body>
<form NAME = "servicepage">


<% 

DomXMLparser domparser_service = new DomXMLparser();
NodeList servList = domparser_service.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/trips", "route");
String servroute_ID = (String)session.getAttribute("route_id");
//String servroute_ID = theBean.getroute_id();
String serviceid = request.getParameter("serviceid");
if(serviceid != null)
request.setAttribute("service_id", serviceid);
%>


<h2>Service List <%=servroute_ID %></h2>

<select NAME = "serviceid" >

<% 

	for(int index = 0; index < getServName(servList,servroute_ID).size(); index++)
	{
%>
<option value = <%= getservice(servList, servroute_ID).get(index) %>>
<%=getServName(servList,servroute_ID).get(index) %>
</option>
<%
	}

%>

</select>
<%

%>

<input type = "button" value = "Search" onClick="servicepage.submit()">


</form>

</body>
</html>

<%!
public ArrayList <String> getServName(NodeList tripList, String routeid){
	ArrayList<String> comparry = new ArrayList<String>();
	
	for (int index = 0; index < getservice(tripList, routeid).size(); index++){
			if (getservice(tripList, routeid).get(index).equals("SAT"))
					comparry.add("Saturday");
		
			if (getservice(tripList, routeid).get(index).equals("WKDY"))
					comparry.add("Weekdays");
		
			if (getservice(tripList, routeid).get(index).equals("SUN"))
					comparry.add("Sunday");
			
			if (getservice(tripList, routeid).get(index).equals("M-FSAT"))
				comparry.add("Saturday");
			
			if (getservice(tripList, routeid).get(index).equals("SUNAB"))
				comparry.add("Sunday");
			
			
		
		}
	return comparry;
}
%>

<%!

public ArrayList <String>getservice(NodeList tripList, String routeid)
{
	ArrayList<String>vector = new ArrayList<String>();
	LinkedHashSet<String> serhashList = new LinkedHashSet<String>();
	for(int index = 0; index < tripList.getLength(); index++)
	   {
		   Node node = tripList.item(index);
		   NamedNodeMap attrs = node.getAttributes();
		   if(attrs.getNamedItem("id").getNodeValue().equals(routeid))
		     {
		       if(node.getNodeType() == Node.ELEMENT_NODE)
		          {
		         Element element = (Element) node; 
		         NodeList serNode = element.getElementsByTagName("service");
		         for(int iIndex=0; iIndex< serNode.getLength(); iIndex++)
			        {
		        	 if(serNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
			         {	
		               Element nameElement = (Element) serNode.item(iIndex);
		                serhashList.add(serNode.item(iIndex).getFirstChild().getNodeValue().trim());
			         }
			        }
		          }  
		     }
	   }
	
	Iterator <String>itr  = serhashList.iterator();
	  while (itr.hasNext()){
	      vector.add(itr.next());
	    }
	
	return vector;
}
%>
