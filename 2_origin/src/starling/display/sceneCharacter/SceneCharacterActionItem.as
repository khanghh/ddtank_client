package starling.display.sceneCharacter
{
   public class SceneCharacterActionItem
   {
       
      
      public var type:String;
      
      public var state:String;
      
      public var frames:Array;
      
      public var repeat:Boolean;
      
      public var total:int;
      
      public function SceneCharacterActionItem(param1:String, param2:String, param3:Array, param4:Boolean, param5:int = 0)
      {
         super();
         this.state = param1;
         this.type = param2;
         this.frames = param3;
         this.repeat = param4;
         this.total = param5 || param3.length;
      }
      
      public function dispose() : void
      {
      }
   }
}
