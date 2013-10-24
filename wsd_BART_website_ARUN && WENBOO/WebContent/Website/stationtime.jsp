<%@page contentType="text/html" import="java.io.*,java.net.*"%>
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="newstylesheet.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Time table by station</title>
</head>
<body  onLoad='initTable("table1");' id = "body">
<SCRIPT SRC="sortTable.js">
</SCRIPT>

<form name ="stationtime" method= "POST">
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
<p>&nbsp;</p>
<%
String station_name = request.getParameter("stationNames");
//String station_value = request.getHeader("stationNames");
ArrayList<String> tripid_name = new ArrayList<String>();
ArrayList name_url = new ArrayList();
DomXMLparser domparser = new DomXMLparser();
NodeList namenodeList = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/stations","station");
NodeList stationnodeList = domparser.getnodelist("http://www-student.it.uts.edu.au/~brookes/bart/stations","station");
URL stationurl = new URL("http://www-student.it.uts.edu.au/~brookes/bart/stop_times?station="+station_name+"");

NodeList trip_node = rest_service(stationurl).getElementsByTagName("trip");
String newnames = "";
String tripOne = new String();
String tripTwo = new String();
int divnum = gettripid(trip_node).size()/2;
       for(int index = 0; index < divnum; index++) 
       {
         //tripid_name.add(gettripid(trip_node).get(index));
         tripOne += gettripid(trip_node).get(index).toString()+ ","; 
         tripid_name.add(tripOne);
       }
       
       for (int index = divnum; index < gettripid(trip_node).size(); index++ )
       {
    	   //tripid_name.add(gettripid(trip_node).get(index));
           tripTwo += gettripid(trip_node).get(index).toString()+ ","; 
           tripid_name.add(tripTwo);
       }    
%>

<div id ="statdiv">
<table>
<tr>
<td>
<h2>Station Names:</h2><br>
   <select name = "stationNames" STYLE="width: 260px">
   <%
     for(int index = 0; index < getStationid(namenodeList).size(); index++)
        {
   %>
      <option value = <%=getStationid(namenodeList).get(index) %>>
      <%= getStationName(namenodeList).get(index)%>
      </option>
   <%
        }
   %>
   </select>
</td>
</tr>
<tr><td> <input type = "button" value = "Search" onClick = "stationtime.submit()"></td></tr>
<tr></tr>
</table>
<hr />
<h3> Timetable: &nbsp;<%=getStationValue(station_name,stationnodeList) %></h4>
<table class = "contacts">
<tr>
      <td class = "helpHed" width="25%">Arrival</td>
      <td class = "helpHed" width="25%">Departure</td>
      <td class = "helpHed" width="25%">Trip</th>
</tr>
</table>
<div id = "wrapper">
<table ID="table1" class = "contacts" align="center">
      <th></th>
      <th></th>
      <th></th>
   <%
  // for(int indexes = 0; indexes < tripid_name.size(); indexes++){
	   
	   URL trip1url = new URL("http://www-student.it.uts.edu.au/~brookes/bart/stop_times?trip="+tripOne+"");
	   URL trip2url = new URL("http://www-student.it.uts.edu.au/~brookes/bart/stop_times?trip="+tripTwo+"");
       NodeList trip_nodes = rest_service(trip1url).getElementsByTagName("trip");
      for (int index = 0; index < deptlist(trip_nodes,station_name).size(); index++)
       {
   %>
   <tr>
      <td  width="25%"><%= arrivallist(trip_nodes,station_name).get(index)%></td>
      <td  width="25%"><%= deptlist(trip_nodes,station_name).get(index)%></td>
      <td  width="25%"><%= tripname(trip_nodes,station_name).get(index)%></td>
    </tr>
    
  <% 
           
       }
      
      trip_nodes = rest_service(trip2url).getElementsByTagName("trip");
      for (int index = 0; index < deptlist(trip_nodes,station_name).size(); index++)
      {
  %>
  <tr>
     <td  width="25%"><%= arrivallist(trip_nodes,station_name).get(index)%></td>
     <td  width="25%"><%= deptlist(trip_nodes,station_name).get(index)%></td>
     <td  width="25%"><%= tripname(trip_nodes,station_name).get(index)%></td>
   </tr>
   
 <% 
          
      }
  // }
 %>
  </table>
</div>
</div>
</div>
</form>

</body>
</html>


<%!
public ArrayList<NodeList> getNodelist (NodeList tripnode){
	ArrayList<NodeList> triplist = new ArrayList<NodeList>();
	triplist.add(tripnode);
	return triplist;
}
%>

<%!

public ArrayList<String> getStationid(NodeList station_Node){
	
	ArrayList <String> statarry = new ArrayList<String>();
	for(int index=0; index < station_Node.getLength(); index++)
	{
		Node value_node = station_Node.item(index);
		if (value_node.getNodeType() == Node.ELEMENT_NODE)
		{
		    Element element = (Element) value_node;
            NamedNodeMap attrs = value_node.getAttributes();
            statarry.add(attrs.getNamedItem("id").getNodeValue());
		}
	}
	
 return statarry;
}
%>

<%!
public ArrayList<String> getStationName(NodeList stat_nodeName){
	ArrayList <String> statarry = new ArrayList<String>();
	for(int index=0; index < stat_nodeName.getLength(); index++)
	{
		    Node node_stat = stat_nodeName.item(index); 
			if (node_stat.getNodeType() == Node.ELEMENT_NODE)
			{
			    Element element = (Element) node_stat;
			    NodeList nameNode = element.getElementsByTagName("name");
			    
			    for(int iIndex=0; iIndex < nameNode.getLength(); iIndex++)
				{
			    	if (nameNode.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
			    	{
			    		Element stat_Element = (Element) nameNode.item(iIndex);
			    		statarry.add(stat_Element.getFirstChild().getNodeValue().trim());
			    	}
			    	
				}
			}
	}
	return statarry;
}
%>

<%!

public ArrayList<String> gettripid(NodeList tripnode){
	ArrayList<String> triparry = new ArrayList<String>();
	for(int index=0; index < tripnode.getLength(); index++)
	{
		Node value_node = tripnode.item(index);
		if (value_node.getNodeType() == Node.ELEMENT_NODE)
		{
		    Element element = (Element) value_node;
            NamedNodeMap attrs = value_node.getAttributes();
            triparry.add(attrs.getNamedItem("id").getNodeValue());
		}
	}
	
	return triparry;
}
%>


<%!
public Document rest_service(URL rest_url) throws Exception{
	DomXMLparser domparser = new DomXMLparser();
	HttpURLConnection conn = (HttpURLConnection) rest_url.openConnection();
	InputStream in = conn.getInputStream();	
	StringBuffer res = new StringBuffer();
	byte[] b = new byte[4096];
	for (int n; (n = in.read(b)) != -1;) {
	  res.append(new String(b, 0, n));
	   }
	   ByteArrayInputStream stat_bytes = new ByteArrayInputStream(res.toString().getBytes("UTF-8"));
	   Document stat_rest = domparser.rest_domlist(stat_bytes);
	  // NodeList tripid_node = stat_rest.getElementsByTagName(nodename);
	   
	   return stat_rest;
}
%>

<%!
public ArrayList<String> tripname(NodeList trip_node, String stationName){
	ArrayList <String> stat_arry = new ArrayList<String>();
	
	for(int index=0; index < trip_node.getLength(); index++)
	{
		Node trip_nodes = trip_node.item(index);
	        NamedNodeMap attrs = trip_nodes.getAttributes();
	        if(trip_nodes.getNodeType() == Node.ELEMENT_NODE)
		      {
	     	         Element element = (Element) trip_nodes;
			         NodeList stop_node = element.getElementsByTagName("stop");
			   for(int stp_index = 0; stp_index < stop_node.getLength(); stp_index++)
			    {
				  Node stp_nodes = stop_node.item(stp_index);
				  if(stp_nodes.getNodeType()== Node.ELEMENT_NODE)
				  {
					  Element stp_element = (Element)stp_nodes;
					  NodeList stat_list = stp_element.getElementsByTagName("station");
				
					  for(int iIndex=0; iIndex< stat_list.getLength(); iIndex++)
				        {
				           if(stat_list.item(iIndex).getNodeType() == Node.ELEMENT_NODE)
					         {	
				        	   if (stat_list.item(iIndex).getFirstChild().getNodeValue().equals(stationName))
				        	   {
				        		   stat_arry.add(attrs.getNamedItem("id").getNodeValue().trim());
				        	   }
				        	   
					         }
				        }
				  }
			    }      
			}
		}
		
		return stat_arry;
	   
	}
	

%>


<%!
public ArrayList<String> deptlist(NodeList trip_node, String stationName){
	ArrayList <String> stat_arry = new ArrayList<String>();
	
	//NodeList trip_node = stat_doc.getElementsByTagName("trip");
	for(int index=0; index < trip_node.getLength(); index++)
	{
		Node trip_nodes = trip_node.item(index);
		if(trip_nodes.getNodeType() == Node.ELEMENT_NODE)
	      {
     	         Element element = (Element) trip_nodes;
		         NodeList stop_node = element.getElementsByTagName("stop");
		   for(int stp_index = 0; stp_index < stop_node.getLength(); stp_index++)
		    {
			  Node stp_nodes = stop_node.item(stp_index);
			  if(stp_nodes.getNodeType()== Node.ELEMENT_NODE)
			  {
				  Element stp_element = (Element)stp_nodes;
				  NodeList stat_list = stp_element.getElementsByTagName("station");
				  NodeList dept_list = stp_element.getElementsByTagName("depart");
				  
				  for(int iIndex=0; iIndex< stat_list.getLength(); iIndex++)
			        {
			           if(stat_list.item(iIndex).getNodeType() == Node.ELEMENT_NODE && 
			              dept_list.item(iIndex).getNodeType()==Node.ELEMENT_NODE)
				         {	
			        	   Element deptElement = (Element) dept_list.item(iIndex);
			        	   if (stat_list.item(iIndex).getFirstChild().getNodeValue().equals(stationName))
			        	   {
			        		   stat_arry.add(deptElement.getFirstChild().getNodeValue().trim());
			        	   }
			        	   
				         }
			        }
			  }
		    }      
		}
	}
	
	return stat_arry;
}
%>



<%!
public ArrayList<String> arrivallist(NodeList trip_node, String stationName){
	ArrayList <String> stat_arry = new ArrayList<String>();
	
	//NodeList trip_node = stat_doc.getElementsByTagName("trip");
	for(int index=0; index < trip_node.getLength(); index++)
	{
		Node trip_nodes = trip_node.item(index);
		if(trip_nodes.getNodeType() == Node.ELEMENT_NODE)
	      {
     	         Element element = (Element) trip_nodes;
		         NodeList stop_node = element.getElementsByTagName("stop");
		   for(int stp_index = 0; stp_index < stop_node.getLength(); stp_index++)
		    {
			  Node stp_nodes = stop_node.item(stp_index);
			  if(stp_nodes.getNodeType()== Node.ELEMENT_NODE)
			  {
				  Element stp_element = (Element)stp_nodes;
				  NodeList stat_list = stp_element.getElementsByTagName("station");
				  NodeList dept_list = stp_element.getElementsByTagName("arrive");
				  
				  for(int iIndex=0; iIndex< stat_list.getLength(); iIndex++)
			        {
			           if(stat_list.item(iIndex).getNodeType() == Node.ELEMENT_NODE && 
			              dept_list.item(iIndex).getNodeType()==Node.ELEMENT_NODE)
				         {	
			        	   Element deptElement = (Element) dept_list.item(iIndex);
			        	   if (stat_list.item(iIndex).getFirstChild().getNodeValue().equals(stationName))
			        	   {
			        		   stat_arry.add(deptElement.getFirstChild().getNodeValue().trim());
			        	   }
			        	   
				         }
			        }
			  }
		    }      
		}
	}
	
	return stat_arry;
}
%>

<%!
public String getStationValue(String stationid, NodeList stationNode){
	//ArrayList<String>namearry = new ArrayList<String>();
	
	String stationname = new String();
	for(int index=0; index < stationNode.getLength(); index++)
	{
	        Node node = stationNode.item(index);
	        NamedNodeMap attrs = node.getAttributes();
	        
	        	if(attrs.getNamedItem("id").getNodeValue().equals(stationid))
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
				        		   stationname = nameElement.getFirstChild().getNodeValue().trim();
					             }
					        }
				      }
		    	  }
	        
	}
	return stationname;
}
%>