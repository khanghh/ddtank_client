package com.pickgliss.loader
{
   public class DataAnalyzer
   {
       
      
      protected var _onCompleteCall:Function;
      
      public var message:String;
      
      public var analyzeCompleteCall:Function;
      
      public var analyzeErrorCall:Function;
      
      public function DataAnalyzer(param1:Function){super();}
      
      public function analyze(param1:*) : void{}
      
      protected function onAnalyzeComplete() : void{}
      
      protected function onAnalyzeError() : void{}
   }
}
