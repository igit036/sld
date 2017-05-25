<?xml version="1.0" encoding="UTF-8"?><sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0">
  <sld:NamedLayer>
    <sld:Name>Default Styler</sld:Name>
    <sld:UserStyle>
      <sld:Name>Default Styler</sld:Name>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <sld:MaxScaleDenominator>5000.0</sld:MaxScaleDenominator>
<!--2D symbol          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#BEB2B2</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.4</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.5</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>		-->
          
<!--  The following rule adds the building shadows      
        <sld:PolygonSymbolizer>
         <sld:Geometry>
          <ogc:Function name='offset'>
           <ogc:PropertyName>geom</ogc:PropertyName>
           <ogc:Literal>3</ogc:Literal>
           <ogc:Literal>-3</ogc:Literal>                
          </ogc:Function>
         </sld:Geometry>
         <sld:Fill>
          <sld:CssParameter name='fill'>#555555</sld:CssParameter>
          <sld:CssParameter name='opacity'>0.25</sld:CssParameter>
         </sld:Fill>
        </sld:PolygonSymbolizer>  -->
        
<!--  The following rule extrudes the polygons to create the sides of the buildings  -->
      
        <sld:PolygonSymbolizer>
         <sld:Geometry>
          <ogc:Function name='isometric'>
           <ogc:PropertyName>geom</ogc:PropertyName>
           <ogc:Literal>6</ogc:Literal>
          </ogc:Function>
         </sld:Geometry>
         <sld:Fill>
          <sld:CssParameter name='fill'>#BEB2B2</sld:CssParameter>
          <sld:CssParameter name="fill-opacity">0.5</sld:CssParameter>
         </sld:Fill>
         <sld:Stroke>
          <sld:CssParameter name='stroke'>#BEB2B2</sld:CssParameter>
          <sld:CssParameter name='stroke-width'>0.1</sld:CssParameter>   
         </sld:Stroke>
        </sld:PolygonSymbolizer>

<!--  The following rule adds a roof to the buildings  -->
      
        <sld:PolygonSymbolizer>
         <sld:Geometry>
          <ogc:Function name='offset'>
            <ogc:PropertyName>geom</ogc:PropertyName>
            <ogc:Literal>0</ogc:Literal>
            <ogc:Literal>6</ogc:Literal>
           </ogc:Function>
          </sld:Geometry>
           <sld:Fill>
            <sld:CssParameter name='fill'>#ede8e8</sld:CssParameter>
            <sld:CssParameter name="fill-opacity">0.7</sld:CssParameter>
           </sld:Fill>
           <sld:Stroke>
            <sld:CssParameter name='stroke'>#BEB2B2</sld:CssParameter>
            <sld:CssParameter name='stroke-width'>0.3</sld:CssParameter>
           </sld:Stroke>
          </sld:PolygonSymbolizer>
          
<!--  The following rule adds label to the buildings  -->
          
          <sld:TextSymbolizer>
            <sld:Label>
              <ogc:PropertyName>housenumber</ogc:PropertyName>
            </sld:Label>
            <sld:Font>
              <sld:CssParameter name="font-family">DejaVu Sans</sld:CssParameter>
              <sld:CssParameter name="font-size">9.5</sld:CssParameter>
              <sld:CssParameter name="font-style">normal</sld:CssParameter>
              <sld:CssParameter name="font-weight">normal</sld:CssParameter>
            </sld:Font>
            <sld:LabelPlacement>
              <sld:PointPlacement>
                <sld:AnchorPoint>
                  <sld:AnchorPointX>0.5</sld:AnchorPointX>
                  <sld:AnchorPointY>0.5</sld:AnchorPointY>
                </sld:AnchorPoint>
              </sld:PointPlacement>
            </sld:LabelPlacement>
            <sld:Fill>
              <sld:CssParameter name="fill">#827b84</sld:CssParameter>
            </sld:Fill>
            <sld:VendorOption name="autoWrap">60</sld:VendorOption>
            <sld:VendorOption name="maxDisplacement">150</sld:VendorOption>
          </sld:TextSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:MinScaleDenominator>5000.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>12500.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#BEB2B2</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.4</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.4</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:MinScaleDenominator>12500.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>50000.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#CAC0C0</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.2</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.4</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:MinScaleDenominator>50000.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>100000.0</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.3</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:MinScaleDenominator>100000.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>200000.0</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.2</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:MinScaleDenominator>200000.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>400000.0</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D5CECE</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">0.1</sld:CssParameter>
            </sld:Fill>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>
