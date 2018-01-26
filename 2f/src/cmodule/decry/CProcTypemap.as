package cmodule.decry
{
   class CProcTypemap extends CTypemap
   {
       
      
      private var retTypemap:CTypemap;
      
      private var varargs:Boolean;
      
      private var argTypemaps:Array;
      
      private var async:Boolean;
      
      function CProcTypemap(param1:CTypemap, param2:Array, param3:Boolean = false, param4:Boolean = false){super();}
      
      override public function createC(param1:*, param2:int = 0) : Array{return null;}
      
      override public function destroyC(param1:Array) : void{}
      
      override public function fromC(param1:Array) : *{return null;}
      
      private function push(param1:*) : void{}
   }
}
