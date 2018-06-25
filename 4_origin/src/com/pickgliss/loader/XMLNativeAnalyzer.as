package com.pickgliss.loader
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class XMLNativeAnalyzer extends DataAnalyzer
   {
       
      
      public function XMLNativeAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = new XML(data);
         ComponentFactory.Instance.setup(xml);
         onAnalyzeComplete();
      }
   }
}
