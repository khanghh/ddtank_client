package ddt.view.sceneCharacter
{
   public class SceneCharacterActionItem
   {
       
      
      public var type:String;
      
      public var frames:Array;
      
      public var repeat:Boolean;
      
      public function SceneCharacterActionItem(type:String, frames:Array, repeat:Boolean)
      {
         super();
         this.type = type;
         this.frames = frames;
         this.repeat = repeat;
      }
      
      public function dispose() : void
      {
         while(frames && frames.length > 0)
         {
            frames.shift();
         }
         frames = null;
      }
   }
}
