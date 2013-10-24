<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dca.tranlist.DomXMLparser"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="servicebean" class="dca.tranlist.Trainlist" scope="session" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<%

%>


<body>
<form name="trippage" action = "triptimetable.jsp">
<%   
    String route_ID = (String)session.getAttribute( "route_id" );
    DomXMLparser domparser_trip = new DomXMLparser();
    NodeList tripList = domparser_trip.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/trips", "route");
    String service_no = (String)request.getAttribute("serv_id");
    String number = "search";
    String trip_id = request.getParameter("triplist");
    if(trip_id != null)
    request.setAttribute("tripid", trip_id);
    
%>
<p>&nbsp;</p>

<h2>Trip List</h2>
<% 
for(int index = 0; index < getoneTrip_name(tripList,route_ID).size(); index++)
{
 %> 
<h4><%=getoneTrip_name(tripList,route_ID).get(index) %> </h4>
<%
}
%>
<select name = "triplist" STYLE="width: 170px">

<% 

   if (service_no == null)
      {
	    for(int index = 0; index < getoneTrip_id(tripList,route_ID).size(); index++)
	       {
%>
<option value = <%= getoneTrip_id(tripList,route_ID).get(index) %>>
<%= getoneTrip_id(tripList,route_ID).get(index) %>
</option>
<%
	       }
      }
   else
      {
	   for (int index = 0; index < getTrip_id(tripList, route_ID, service_no).size(); index++)
	       {
	%>
		   <option>
		   <%= getTrip_id(tripList,route_ID,service_no).get(index) %>
		   </option>
   <% 
	       }
      }
%>
</select>
<br>
<p><input type = "button" value = " Search Timetable" onClick = "trippage.submit()"></p>

</form>
<p></p>
</body>
</html>



  <%!
	 public static ArrayList <String> getTrip_id(NodeList tripnode, String routeid, String serviceid)
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
	 public static ArrayList <String> getoneTrip_id(NodeList tripnode, String routeid)
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

							             vector.add(tripattrs.getNamedItem("id").getNodeValue().trim());
					                  
				                 }
			                }
				      }
				  }
			}

			return vector;
		}
      %>
      
      
      
      
       <%!
	 public static ArrayList <String> getTrip_name(NodeList tripnode, String routeid, String serviceid)
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
	 public static ArrayList <String> getoneTrip_name(NodeList tripnode, String routeid)
		{
			ArrayList<String>vector = new ArrayList<String>();
			LinkedHashSet<String> namehashList = new LinkedHashSet<String>();
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
					                 
							             namehashList.add(nameElement.getFirstChild().getNodeValue().trim());
				                 }
			                }
				      }
				  }
			}
			
			Iterator <String>itr  = namehashList.iterator();
			  while (itr.hasNext()){
			      vector.add(itr.next());
			    }

			return vector;
		}
	 %>

