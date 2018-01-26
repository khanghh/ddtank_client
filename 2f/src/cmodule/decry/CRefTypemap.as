package cmodule.decry
{
   class CRefTypemap extends CTypemap
   {
       
      
      private var subtype:CTypemap;
      
      function CRefTypemap(param1:CTypemap){super();}
      
      override public function fromC(param1:Array) : *{return null;}
      
      override public function createC(param1:*, param2:int = 0) : Array{return null;}
   }
}
