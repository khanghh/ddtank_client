package com.pickgliss.loader
{
   public class DataAnalyzer
   {
       
      
      protected var _onCompleteCall:Function;
      
      public var message:String;
      
      public var analyzeCompleteCall:Function;
      
      public var analyzeErrorCall:Function;
      
      public function DataAnalyzer(onCompleteCall:Function)
      {
         super();
         _onCompleteCall = onCompleteCall;
      }
      
      public function analyze(data:*) : void
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
