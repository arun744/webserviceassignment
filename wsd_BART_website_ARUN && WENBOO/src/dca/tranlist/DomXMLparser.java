package dca.tranlist;

import javax.xml.parsers.*;
import org.w3c.dom.*; 
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.io.*;
import java.util.*;

public class DomXMLparser {
	
	  public NodeList getnodelist(String url, String nodename ) throws ParserConfigurationException{
		  DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		  factory.setIgnoringElementContentWhitespace(true); 
		  DocumentBuilder db = factory.newDocumentBuilder();
		  Document doc = null;
		try {
			doc = db.parse(url);
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		  NodeList nodeList = doc.getElementsByTagName(nodename);
		  return nodeList;
	  }
	  
	  
	  public Document rest_domlist(ByteArrayInputStream bytes) throws ParserConfigurationException{
		  DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		  factory.setIgnoringElementContentWhitespace(true); 
		  DocumentBuilder db = factory.newDocumentBuilder();
		  Document doc = null;
		try {
			doc = db.parse(bytes);
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		  //NodeList nodeList = doc.getElementsByTagName(nodename);
		  return doc;
	  }
}

