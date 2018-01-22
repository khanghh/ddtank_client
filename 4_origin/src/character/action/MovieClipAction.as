package character.action
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   
   public class MovieClipAction extends BaseAction
   {
       
      
      public function MovieClipAction(param1:MovieClip, param2:String = "", param3:String = "", param4:uint = 0, param5:Boolean = false)
      {
         _asset = param1;
         _len = param1.totalFrames;
         super(param2,param3,param4,param5);
         _type = BaseAction.MOVIE_ACTION;
      }
      
      override public function get isEnd() : Boolean
      {
         return MovieClip(_asset).currentFrame >= MovieClip(_asset).totalFrames;
      }
      
      override public function reset() : void
      {
         MovieClip(_asset).gotoAndStop(1);
      }
      
      public function set asset(param1:DisplayObject) : void
      {
         if(_asset.parent)
         {
            _asset.parent.removeChild(_asset);
         }
         _asset = param1;
      }
      
      override public function toXml() : XML
      {
         var _loc1_:XML = super.toXml();
         _loc1_.@asset = getQualifiedClassName(_asset).replace("::",".");
         return _loc1_;
      }
   }
}
