package com.pickgliss.loader{   public class DataAnalyzer   {                   protected var _onCompleteCall:Function;            public var message:String;            public var analyzeCompleteCall:Function;            public var analyzeErrorCall:Function;            public function DataAnalyzer(onCompleteCall:Function) { super(); }
            public function analyze(data:*) : void { }
            protected function onAnalyzeComplete() : void { }
            protected function onAnalyzeError() : void { }
   }}