<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page  import="java.io.*,java.net.*"%>
 <%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dca.tranlist.DomXMLparser"%>
<%@ page import= "org.xml.sax.InputSource"%>  
<%@ page import= "org.xml.sax.SAXException"%>
<%@ page import="dca.tranlist.DomXMLparser"%>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "javax.xml.transform.*" %>
<%@ page import = " javax.xml.transform.dom.DOMSource" %>
<%@ page import =  "javax.xml.transform.stream.StreamResult"%>
<%@ page import = "java.net.URL" %>
<jsp:useBean id="servicebean" class="dca.tranlist.Trainlist" scope="session" />
<jsp:setProperty name="servicebean" property="trip_id" param="triplist" />
 
 
<html>
<head>
<link rel="stylesheet" type="text/css" href="newstylesheet.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trip Timetable</title>
</head>
<body id = "body">
<form name = "stationpage">
<div align = "center" >
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
 String route_id = (String)session.getAttribute( "route_id" );
 String trip_name = servicebean.gettrip_id();
 String station_id = request.getParameter("stationlist");
 ArrayList<String> statarry = new ArrayList<String>();
 ArrayList<String> stoparry = new ArrayList<String>();
 ArrayList<String> deptarry = new ArrayList<String>();
 ArrayList<String> chkarry = new ArrayList<String>();
 
//using RESTful webserice


 URL url = new URL("http://www-student.it.uts.edu.au/~brookes/bart/stop_times?trip="+trip_name+"");

 DomXMLparser domparser = new DomXMLparser();
 NodeList routenode = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/routes", "route");
 
try {

HttpURLConnection conn = (HttpURLConnection) url.openConnection();
InputStream in = conn.getInputStream();	
StringBuffer res = new StringBuffer();
byte[] b = new byte[4096];
for (int n; (n = in.read(b)) != -1;) {
  res.append(new String(b, 0, n));
   }
   ByteArrayInputStream bytes = new ByteArrayInputStream(res.toString().getBytes("UTF-8"));
  Document rest_doc = domparser.rest_domlist(bytes);
  NodeList statnode = rest_doc.getElementsByTagName("station");
  NodeList stopnode = rest_doc.getElementsByTagName("arrive");
  NodeList deptnode = rest_doc.getElementsByTagName("depart");
  for(int index = 0; index < statnode.getLength(); index++)
  {
   statarry.add(statnode.item(index).getFirstChild().getNodeValue());
   stoparry.add(stopnode.item(index).getFirstChild().getNodeValue());
   deptarry.add(deptnode.item(index).getFirstChild().getNodeValue());
   
  }

} catch(Exception e) {

	out.println(e.getMessage());

}
%>

<p>&nbsp;</p>


<div id = "divcolor">

<h2><%=servicebean.gettrip_id()%> Trip Timetable</h2>
<table>
 <tr>
   <td>
    <table >
   <tr>
     <td class = "helpHed" width="25%">Station Name</td>
     <td class = "helpHed" width="25%">Arrival</td>
     <td class = "helpHed" width="25%">Departure</td>
     <td class = "helpHed" width="25%">Route</td>
  </tr>
  </table>
   <div id = "wrapper1">
   <table>
  
<%
NodeList namenodeList = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/stations","station");

for(int index = 0; index < getStation(statarry,namenodeList).size(); index++ )
{
%>
<tr>
<td class="contact" width="25%">
<a href = <%=geturllink( statarry,namenodeList).get(index)%> target="blank">
<%=getStation(statarry,namenodeList).get(index)%> 
</a>
</td>

<td class="contact" width="25%">
<%= stoparry.get(index)%>
</td>

<td class="contact" width="25%">
<%= deptarry.get(index)%>
</td>
<td class="contact" width="25%">
<%= getroutename(route_id,routenode)%>
</td>
</tr>
<%
}
%>
</table>
</div>
   </td>
 </tr>
</table>

 <table>
  <tr>
    <td>
     <div> <a href="http://localhost:8080/webservice1/Website/router.jsp" ><img src="image/routebtn.png" width="142" height="28" /></a></div>
    </td>
  </tr>
    <tr>
     <td>
       <h2>Search Station Map: &nbsp;</h2>
     </td>
     <td>
     <p>&nbsp;</p>
        <select name = "stationlist" STYLE="width: 170px" >
         <%

         for(int index = 0; index < getStation(statarry,namenodeList).size(); index++ )
         {
          %>
            <option value = <%=statarry.get(index)%>>
                <%=getStation(statarry,namenodeList).get(index)%>
            </option>
         <%
         }
          %>
    </select>
    <p><input type = "button" value = "Search" onClick = "stationpage.submit()"></p>
     </td>
   </tr>
</table>
<table>
<tr>
<td>
   <%
       for(int index = 0; index < getlongitude(statarry,namenodeList, station_id).size(); index++ )
          {
	        String latitude = getlatitude(statarry,namenodeList,station_id).get(index);
	        String longitude = getlongitude(statarry,namenodeList,station_id).get(index);
   %>
              <p>
                 <iframe width="425" height="350" src="http://maps.google.com/maps?q=<%=latitude%>,<%=longitude%>&amp;ie=UTF8&amp;output=embed"></iframe>
             </p>
   <tr>
<td>
<p id= "form-font1">Visit:</p>
<a id = "linkfont" href= <%=geturl(statarry,namenodeList,station_id).get(index)%>>
<%=geturl(statarry,namenodeList,station_id).get(index)%>
</a>
</td>
</tr>
</td>

<%
          }
  %>
</tr>
</table>
</div>



<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


</div>
</form>
</body>
</html>


<%!
public ArrayList<String> getStation(ArrayList<String> statarry, NodeList stationNode){
	ArrayList<String>namearry = new ArrayList<String>();
	
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        for (int statid = 0; statid < statarry.size(); statid++)
	        {
	        	if(attrs.getNamedItem("id").getNodeValue().equals(statarry.get(statid)))
		     	  {
	        		if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList nameNode = element.getElementsByTagName("name");
				         for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
				        	   if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
					             { 
				        		   Element nameElement = (Element) nameNode.item(iIndex);
				        		   namearry.add(nameElement.getFirstChild().getNodeValue().trim());
					             }
					        }
				      }
		    	  }
	        }
	}
	return namearry;
}
%>

<%!
public ArrayList<String> geturl(ArrayList<String> statarry, NodeList stationNode, String statid){
	ArrayList<String>namearry = new ArrayList<String>();
	
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        	if(attrs.getNamedItem("id").getNodeValue().equals(statid))
		     	  {
	        		if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList nameNode = element.getElementsByTagName("url");
				         for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
				        	   if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
					             { 
				        		   Element nameElement = (Element) nameNode.item(iIndex);
				        		   namearry.add(nameElement.getFirstChild().getNodeValue().trim());
					             }
					        }
				      }
		    	  }
	        
	}
	return namearry;
}
%>
<%!
public ArrayList<String> geturllink(ArrayList<String> statarry, NodeList stationNode){
	ArrayList<String>namearry = new ArrayList<String>();
	
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        for (int statid = 0; statid < statarry.size(); statid++)
	        {
	        	if(attrs.getNamedItem("id").getNodeValue().equals(statarry.get(statid)))
		     	  {
	        		if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList nameNode = element.getElementsByTagName("url");
				         for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
				        	
						        		 if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
							             { 
						        	       Element nameElement = (Element) nameNode.item(iIndex);
				        		           namearry.add(nameElement.getFirstChild().getNodeValue().trim());
						        	    }
					             
				        	  
					        }
				      }
		    	  }
	        }  
	}
	return namearry;
}
%>

<%!
public ArrayList<String> getlongitude(ArrayList<String> statarry, NodeList stationNode, String statid){
	ArrayList<String>namearry = new ArrayList<String>();
	
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        	if(attrs.getNamedItem("id").getNodeValue().equals(statid))
		     	  {
	        		if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList nameNode = element.getElementsByTagName("longitude");
				         for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
				        	   if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
					             { 
				        		   Element nameElement = (Element) nameNode.item(iIndex);
				        		   namearry.add(nameElement.getFirstChild().getNodeValue().trim());
					             }
					        }
				      }
		    	  }
	        
	}
	return namearry;
}
%>

<%!
public ArrayList<String> getlatitude(ArrayList<String> statarry, NodeList stationNode, String statid){
	ArrayList<String>namearry = new ArrayList<String>();
	
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        	if(attrs.getNamedItem("id").getNodeValue().equals(statid))
		     	  {
	        		if(node.getNodeType() == Node.ELEMENT_NODE)
				      {
				         Element element = (Element) node; 
				         NodeList nameNode = element.getElementsByTagName("latitude");
				         for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
					        {
				        	   if(nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
					             { 
				        		   Element nameElement = (Element) nameNode.item(iIndex);
				        		   namearry.add(nameElement.getFirstChild().getNodeValue().trim());
					             }
					        }
				      }
		    	  }
	        
	}
	return namearry;
}
%>


<%!
public String getroutename(String routeid, NodeList routelist){
	String routename = new String();
	
	for(int index=0; index < routelist.getLength(); index++)
	{      Node node = routelist.item(index); 
	       if (node.getNodeType() == Node.ELEMENT_NODE)
	           {
	               Element element = (Element) node;
	               NamedNodeMap attrs = node.getAttributes();
		           NodeList nameNode = element.getElementsByTagName("name");
		           
		           if(attrs.getNamedItem("id").getNodeValue().equals(routeid))
		           {
		        	   
		        	   for(int iIndex=0; iIndex< nameNode.getLength(); iIndex++)
						{
						    if (nameNode.item(iIndex).getNodeType() ==Node.ELEMENT_NODE)
							   {   	
						    	Element nameElement = (Element) nameNode.item(iIndex);
						    	routename = nameElement.getFirstChild().getNodeValue().trim();
							   }
						}
		           }
	           }
	
	}
	
	return routename;
}
%>

