<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dca.tranlist.DomXMLparser"%>
<jsp:useBean id="theBean" class="dca.tranlist.Trainlist" scope="session" /> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="newstylesheet.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BART routes</title>
</head>



<body id = "body">
<form name = "routerpage">
<div align = "center">
<table>
<tr><td height="111"><div><img src="image/Title2.gif" width="738" height="105" /></div></td></tr>
</table>
<table class = "divpos_fixed">
<tr id = "td">
<td id = "td1" height="42" width="100" align="center"><a style="color:#FFFFFF" href="http://localhost:8080/webservice1/Website/router.jsp" >Routes</a></td>
<td id = "td1" height="42" width="100" align="center"><a  style="color:#FFFFFF" href="http://localhost:8080/webservice1/Website/stationtime.jsp">Station timetable</a></td>
<td id = "td1" height="42" width="100" align="center"><a style="color:#FFFFFF" href="http://localhost:8080/webservice1/Website/farecalculator.jsp">Fare calculator</a> </td>
</tr>
</table>



<%
  DomXMLparser domparser = new DomXMLparser();
  NodeList nodeList = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/routes", "route");
  NodeList serviceList = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/trips", "route");
  String routeid = request.getParameter("route");
  String serviceid = request.getParameter("serviceid");
  if(serviceid != null && !serviceid.equals("NULL"))
  request.setAttribute("serv_id", serviceid);
  if (routeid != null)
     session.setAttribute( "route_id", routeid );
     String route_id = (String)session.getAttribute( "route_id" );
  
  
  
%>
<table bgcolor="#FFFFFF ">
        <tr height="2px">
        
          <td ><p>&nbsp;</p><h2>Select route</h2>
		     <p>
		       <select NAME ="route" size = <%= nodeList.getLength() %> onClick = "routerpage.submit()">
		         
		         <%
		for(int index=0; index < nodeList.getLength(); index++)
		{
		        Node node = nodeList.item(index); 
			if (node.getNodeType() == Node.ELEMENT_NODE)
			{
			    Element element = (Element) node;
			    NamedNodeMap attrs = node.getAttributes();
				NodeList nameNode = element.getElementsByTagName("name");
				NodeList colorNode = element.getElementsByTagName("color");
				for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
				{
				        if (nameNode.item(iIndex).getNodeType() ==Node.ELEMENT_NODE &&
				        		colorNode.item(iIndex).getNodeType() ==Node.ELEMENT_NODE)
					{   	
						Element nameElement = (Element) nameNode.item(iIndex);
						Element colorElement = (Element) colorNode.item(iIndex);
				%>
		         <option value = <%=attrs.getNamedItem("id").getNodeValue() %>
						 style= "background-color:#<%=colorElement.getFirstChild().getNodeValue().trim()%>">
		           <%=nameElement.getFirstChild().getNodeValue().trim() %>	             </option>	
                 <%
				    }
		       }
		   }
		}
		
		%>
               </select>
               &nbsp;&nbsp;&nbsp;&nbsp;
	        </p>
	      </td>
       <p>&nbsp;</p>
       <td>
       <img src="image/system-map29.gif" width="400" height="300" />
       </td>
	 </tr>	 
	
	<tr >
	     <td>
	     <h2>Select service</h2>
               <select NAME = "serviceid" STYLE="width: 170px">
                 <option value = NULL>Search by service</option>
          <% 

	          for(int index = 0; index < getServName(serviceList,route_id).size(); index++)
	             {
          %>        
                    <option value = <%= getservice(serviceList, route_id).get(index) %>>
                     <%=getServName(serviceList,route_id).get(index) %>
                    </option>
          <%
	             }

          %>

    </select>
    <input type = "button" value = "Search" onClick = "routerpage.submit()">
          </form>
         </td>
	        <td>
	        <%@ include file="trip_list.jsp" %>
	        </td>
	   </tr>
	   
</table>
</div>

</body>
</html>


	 <%!
	 public static ArrayList <String> getStat_list(NodeList tripnode, String routeid, String serviceid)
		{
			ArrayList<String>vector = new ArrayList<String>();
			for(int index=0; index < tripnode.getLength(); index++)
			{
			        Node node = tripnode.item(index);
			        NamedNodeMap attrs = node.getAttributes();
			   if(attrs.getNamedItem("id").getNodeValue().equals(routeid))
			     {
				    if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList rateNode = element.getElementsByTagName("service");
					     NodeList nameNode = element.getElementsByTagName("headsign");
					     
					     for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
					           if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
						         {	
					               Element nameElement = (Element) nameNode.item(iIndex);
					                 if(rateNode.item(iIndex).getFirstChild().getNodeValue().equals(serviceid))
					                   {
							             vector.add(nameElement.getFirstChild().getNodeValue().trim());
						               }
				                 }
			                }
				      }
				  }
			}

			return vector;
		}
	 %>
	 
	 
    <%!
	 public static ArrayList <String> getStat_id(NodeList tripnode, String routeid, String serviceid)
		{
			ArrayList<String>vector = new ArrayList<String>();
			for(int index=0; index < tripnode.getLength(); index++)
			{
			        Node node = tripnode.item(index);
			        NamedNodeMap attrs = node.getAttributes();
			   if(attrs.getNamedItem("id").getNodeValue().equals(routeid))
			     {
				    if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList rateNode = element.getElementsByTagName("service");
					     NodeList nameNode = element.getElementsByTagName("trip");
					     
					     for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
					    	    Node routenode = nameNode.item(iIndex);
						        NamedNodeMap tripattrs = routenode.getAttributes();
					           if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
						         {	
					               Element nameElement = (Element) nameNode.item(iIndex);
					                 if(rateNode.item(iIndex).getFirstChild().getNodeValue().equals(serviceid))
					                   {
							             vector.add(tripattrs.getNamedItem("id").getNodeValue().trim());
					                   }
				                 }
			                }
				      }
				  }
			}

			return vector;
		}
      %>
      
<%!
public ArrayList <String> getServName(NodeList tripList){
	ArrayList<String> comparry = new ArrayList<String>();
	
	for (int index = 0; index < getservice(tripList).size(); index++){
			if (getservice(tripList).get(index).equals("SAT"))
					comparry.add("Other service - Saturday");
		
			if (getservice(tripList).get(index).equals("WKDY"))
					comparry.add("Other service - Weekdays");
		
			if (getservice(tripList).get(index).equals("SUN"))
					comparry.add("Other service -Sunday");
			
			if (getservice(tripList).get(index).equals("M-FSAT"))
				comparry.add("AirBart service - Saturday");
			
			if (getservice(tripList).get(index).equals("SUNAB"))
				comparry.add("AirBart service - Sunday");
			
			
		
		}
	return comparry;
}
%>

   
<%!

public ArrayList <String>getservice(NodeList tripList)
{
	ArrayList<String>vector = new ArrayList<String>();
	LinkedHashSet<String> serhashList = new LinkedHashSet<String>();
	for(int index = 0; index < tripList.getLength(); index++)
	   {
		   Node node = tripList.item(index);
		   NamedNodeMap attrs = node.getAttributes();
        
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
	
	Iterator <String>itr  = serhashList.iterator();
	  while (itr.hasNext()){
	      vector.add(itr.next());
	    }
	
	return vector;
}


%>

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
