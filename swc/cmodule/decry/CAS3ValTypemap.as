package cmodule.decry
{
   class CAS3ValTypemap extends CTypemap
   {
       
      
      private var values:ValueTracker;
      
      function CAS3ValTypemap(){super();}
      
      override public function fromC(param1:Array) : *{return null;}
      
      override public function createC(param1:*, param2:int = 0) : Array{return null;}
      
      override public function destroyC(param1:Array) : void{}
      
      public function get valueTracker() : ValueTracker{return null;}
   }
}
