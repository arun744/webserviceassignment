<%@ page language="java" %>
<%@ page import = "java.util.*" %>
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

<html>
<head>
   <link rel="stylesheet" type="text/css" href="newstylesheet.css"/>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   <title>Fare calculator</title> 
</head>
   <body id = "body"> 
   <form action = "farecalculator.jsp" name ="farecalculator">
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
   try{
	   
	    
		client.Fare service = new client.Fare();
		client.FarePortType port = service.getFarePort();
		 // TODO initialize WS operation arguments here
		client.GetFareRequestType fareparameters = new client.GetFareRequestType();
		client.GetStationsRequestType statparameter = new client.GetStationsRequestType();
		
	// TODO process result here
	
	client.GetStationsResponseType responseType = port.getStations(statparameter);
	   String xml = " ";
	   xml = responseType.getDocument();
       StringReader sr = new StringReader(xml);
       InputSource is = new InputSource(sr);
       DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
       DocumentBuilder builder = factory.newDocumentBuilder();
       Document document = builder.parse(is);
       NodeList nodestat = document.getElementsByTagName("name");
       NodeList statnode = document.getElementsByTagName("station");
	   %>
	 <div id ="farediv">
	 <p>&nbsp;</p>
	 <h2>Fare Calculator</h2>
	   <table>
	   <tr>
	   <td id = "font-underline"> Source station :</td>
	   <td>
	      <select NAME = "Source" id ="combo_style">
	        <% 
	         for (int index = 0; index < nodestat.getLength(); index++)
	             {
		     %>
	               <option value = <%= getStationid(statnode).get(index) %>>
	               <%= nodestat.item(index).getFirstChild().getNodeValue().trim()%>
	               </option>
	         <% 
	             } 
	         %>
	     </select>
	     </td>
	     </tr>
	     <tr>
	       <td>
	       &nbsp;
	       <br />
	       </td>
	     </tr>
	     <tr>
	       <td id = "font-underline">
	        Destination station :
	       </td>
	       <td>
	          <select NAME = "Destination" id ="combo_style">
	        <% 
	         for (int index = 0; index < nodestat.getLength(); index++)
	             {
		     %>
	               <option value = <%= getStationid(statnode).get(index) %>>
	               <%= nodestat.item(index).getFirstChild().getNodeValue().trim()%>
	               </option>
	         <% 
	             }
	        
	        String sourceID = request.getParameter("Source");
	        String destinationID = request.getParameter("Destination");
	        fareparameters.setDestinationStation(sourceID);
			fareparameters.setSourceStation(destinationID);
			client.GetFareResponseType fareresult = port.getFare(fareparameters);
	         %>
	         </select>
	       </td>
	     </tr>
	     <tr>
	       <td>
	         <br>
	       </td>
	     </tr>
	     <tr>
	       <td>
	       </td>
	       <td>
	       <input type="button" value="Calculate"  onClick = "farecalculator.submit()"/>
	       </td>
	     </tr>
	     </table>
	     <hr>
	     <table class = "backsetup" width = "340px" height = "170px">
	        <tr>
	          <td id = "font3" bgcolor="#99CC33">
	          &nbsp;
	         From: <%=getstationname(sourceID,statnode)%>
	          </td>
	          </tr>
	          <tr id = "font3" bgcolor="#99CC33">
	            <td>
	            &nbsp;
	             To: <%=getstationname(destinationID,statnode)%>
	            </td>
	          </tr>
	          
	         <tr id = "font2">
	           <td>
	           &nbsp;&nbsp;&nbsp;
	           Price: &nbsp;<%= fareresult.getCurrency()%> &nbsp; <%=fareresult.getFare()%>
	           </td>
	         </tr>
	     </table>
	</div>     
	  <% 
        }
         catch(Exception e){   
        }
       %>
     <p></p>
</div>
</form>
   </body> 
</html>

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
public String getstationname(String routeid, NodeList routelist){
	String stationname = new String();
	
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
						    	stationname = nameElement.getFirstChild().getNodeValue().trim();
							   }
						}
		           }
	           }
	
	}
	return stationname;
}

%>
