package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ChatFacePanel extends ChatBasePanel
   {
      
      public static const FIGHT_FACE_ID_START:int = 49;
      
      public static const FIGHT_FACE_ID_END:int = 74;
      
      private static const MAX_FACE_CNT:uint = 72;
      
      private static const COLUMN_LENGTH:uint = 10;
      
      private static const FACE_SPAN:uint = 25;
       
      
      protected var _bg:ScaleBitmapImage;
      
      private var _faceBtns:Vector.<BaseButton>;
      
      private var _inGame:Boolean;
      
      private var _selected:int;
      
      public function ChatFacePanel(param1:Boolean = false)
      {
         _faceBtns = new Vector.<BaseButton>();
         super();
         _inGame = param1;
      }
      
      public function dispose() : void
      {
         removeChild(_bg);
         var _loc3_:int = 0;
         var _loc2_:* = _faceBtns;
         for each(var _loc1_ in _faceBtns)
         {
            _loc1_.dispose();
         }
         _faceBtns = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selected() : int
      {
         return _selected;
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         var _loc3_:String = (param1.target as BaseButton).backStyle;
         SoundManager.instance.play("008");
         var _loc2_:int = _loc3_.slice(_loc3_.length - 2);
         if(_loc2_ >= 49 && _loc2_ <= 71)
         {
            _loc2_ = _loc2_ + 30;
         }
         _selected = _loc2_;
         dispatchEvent(new Event("select"));
      }
      
      protected function createBg() : void
      {
         _bg = ComponentFactory.Instance.creat("chat.FacePanelBg");
         _bg.y = -77;
         addChild(_bg);
      }
      
      override protected function init() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         super.init();
         createBg();
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("chat.FacePanelFacePos");
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         var _loc1_:Array = PathManager.solveChatFaceDisabledList();
         _loc6_ = 1;
         while(_loc6_ < 72)
         {
            if(!(_loc1_ && _loc1_.indexOf(String(_loc6_)) > -1))
            {
               if(_loc2_ == 10)
               {
                  _loc2_ = 0;
                  _loc3_++;
               }
               _loc5_ = new BaseButton();
               _loc5_.beginChanges();
               _loc5_.backStyle = "asset.chat.FaceBtn_" + (_loc6_ < 10?"0" + String(_loc6_):String(_loc6_));
               _loc5_.tipStyle = "core.ChatFaceTips";
               _loc5_.tipDirctions = "4";
               _loc5_.tipGapV = 5;
               _loc5_.tipGapH = -5;
               _loc5_.tipData = LanguageMgr.GetTranslation("tank.view.chat.ChatFacePannel.face" + String(_loc6_));
               _loc5_.commitChanges();
               _loc5_.x = _loc2_ * 25 + _loc4_.x;
               _loc5_.y = _loc3_ * 25 + _loc4_.y;
               _loc5_.addEventListener("click",__itemClick);
               _faceBtns.push(_loc5_);
               addChild(_loc5_);
               _loc2_++;
            }
            _loc6_++;
         }
      }
   }
}
