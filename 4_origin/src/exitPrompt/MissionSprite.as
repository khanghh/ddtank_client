package exitPrompt
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class MissionSprite extends Sprite implements Disposeable
   {
       
      
      public var oldHeight:int;
      
      private const BG_X:int = 4;
      
      public const BG_Y:int = -25;
      
      private const BG_WIDTH:int = 290;
      
      private var _arr:Array;
      
      public function MissionSprite(param1:Array)
      {
         super();
         _arr = param1;
         _init(_arr);
      }
      
      private function _init(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.MissionText0");
            _loc2_.text = param1[_loc6_][0] as String;
            _loc2_.y = _loc2_.height * _loc6_ * 3 / 2 - 6;
            addChild(_loc2_);
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.MissionText1");
            _loc3_.text = param1[_loc6_][1] as String;
            _loc3_.y = _loc3_.height * _loc6_ * 3 / 2 - 4;
            addChild(_loc3_);
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ExitPromptFrame.item.line");
            _loc5_.y = _loc2_.height * _loc6_ * 3 / 2 + 16;
            addChild(_loc5_);
            _loc6_++;
         }
         oldHeight = height;
         var _loc4_:Sprite = new Sprite();
         _loc4_.graphics.beginFill(6899489,1);
         _loc4_.graphics.drawRoundRect(0,0,290,35,5,5);
         _loc4_.graphics.endFill();
         addChild(_loc4_);
         _loc4_.x = 4;
         _loc4_.y = -25;
         _loc4_.height = this.height - -25;
         setChildIndex(_loc4_,0);
      }
      
      public function get content() : Array
      {
         return _arr;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
