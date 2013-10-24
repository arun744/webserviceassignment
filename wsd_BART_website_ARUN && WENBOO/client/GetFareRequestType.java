
package client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for getFareRequestType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="getFareRequestType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;all>
 *         &lt;element name="sourceStation" type="{tns:fare}stationNameType" form="unqualified"/>
 *         &lt;element name="destinationStation" type="{tns:fare}stationNameType" form="unqualified"/>
 *       &lt;/all>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "getFareRequestType", propOrder = {

})
public class GetFareRequestType {

    @XmlElement(required = true)
    protected String sourceStation;
    @XmlElement(required = true)
    protected String destinationStation;

    /**
     * Gets the value of the sourceStation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSourceStation() {
        return sourceStation;
    }

    /**
     * Sets the value of the sourceStation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSourceStation(String value) {
        this.sourceStation = value;
    }

    /**
     * Gets the value of the destinationStation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDestinationStation() {
        return destinationStation;
    }

    /**
     * Sets the value of the destinationStation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDestinationStation(String value) {
        this.destinationStation = value;
    }

}
