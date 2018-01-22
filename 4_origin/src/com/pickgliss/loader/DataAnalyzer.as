package com.pickgliss.loader
{
   public class DataAnalyzer
   {
       
      
      protected var _onCompleteCall:Function;
      
      public var message:String;
      
      public var analyzeCompleteCall:Function;
      
      public var analyzeErrorCall:Function;
      
      public function DataAnalyzer(param1:Function)
      {
         super();
         _onCompleteCall = param1;
      }
      
      public function analyze(param1:*) : void
      {
      }
      
      protected function onAnalyzeComplete() : void
      {
         if(_onCompleteCall != null)
         {
            _onCompleteCall(this);
         }
         if(analyzeCompleteCall != null)
         {
            analyzeCompleteCall();
         }
         _onCompleteCall = null;
         analyzeCompleteCall = null;
      }
      
      protected function onAnalyzeError() : void
      {
         if(analyzeErrorCall != null)
         {
            analyzeErrorCall();
         }
      }
   }
}
