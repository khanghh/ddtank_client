package com.pickgliss.events
{
   public class ModelEvent
   {
       
      
      private var source:Object;
      
      public function ModelEvent(source:Object)
      {
         super();
         this.source = source;
      }
      
      public function getSource() : Object
      {
         return source;
      }
   }
}
