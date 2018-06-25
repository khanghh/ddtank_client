package starling.display.sceneCharacter
{
   public class SceneCharacterActionItem
   {
       
      
      public var type:String;
      
      public var state:String;
      
      public var frames:Array;
      
      public var repeat:Boolean;
      
      public var total:int;
      
      public function SceneCharacterActionItem(state:String, type:String, frames:Array, repeat:Boolean, total:int = 0)
      {
         super();
         this.state = state;
         this.type = type;
         this.frames = frames;
         this.repeat = repeat;
         this.total = total || frames.length;
      }
      
      public function dispose() : void
      {
      }
   }
}
