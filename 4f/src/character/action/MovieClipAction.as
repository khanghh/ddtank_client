package character.action
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   
   public class MovieClipAction extends BaseAction
   {
       
      
      public function MovieClipAction(param1:MovieClip, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false){super(null,null,null,null);}
      
      override public function get isEnd() : Boolean{return false;}
      
      override public function reset() : void{}
      
      public function set asset(param1:DisplayObject) : void{}
      
      override public function toXml() : XML{return null;}
   }
}
