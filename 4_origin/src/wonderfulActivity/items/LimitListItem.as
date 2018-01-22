package wonderfulActivity.items
{
   import activeEvents.data.ActiveEventsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class LimitListItem extends Sprite
   {
      
      public static const ITEM_CHANGE:String = "itemChange";
       
      
      private var _info:ActiveEventsInfo;
      
      private var _btn:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _isSeleted:Boolean;
      
      private var _func:Function;
      
      private var _selecetHander:Function;
      
      public function LimitListItem(param1:ActiveEventsInfo, param2:Function, param3:Function)
      {
         super();
         _info = param1;
         _func = param2;
         _selecetHander = param3;
         initView();
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.back");
         addEventListener("click",clickHander);
         addChild(_btn);
         buttonMode = true;
         useHandCursor = true;
         initTxt();
      }
      
      public function setSelectBtn(param1:Boolean) : void
      {
         _isSeleted = param1;
         DisplayUtils.setFrame(_btn,!!_isSeleted?2:1);
         initTxt();
         dispatchEvent(new Event("itemChange"));
      }
      
      private function initTxt() : void
      {
         if(_txt)
         {
            ObjectUtils.disposeObject(_txt);
            _txt = null;
         }
         if(_isSeleted)
         {
            _txt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.seleBtnTxt");
         }
         else
         {
            _txt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.unseleBtnTxt");
         }
         _txt.text = changeTitle();
         addChild(_txt);
      }
      
      private function changeTitle() : String
      {
         var _loc2_:* = "";
         var _loc1_:String = "· " + _info.Title;
         if(_loc1_.length > 8)
         {
            _loc2_ = _loc1_.substr(0,8) + "...";
         }
         else
         {
            _loc2_ = _loc1_;
         }
         return _loc2_;
      }
      
      public function initRightView() : Function
      {
         return _func(_info);
      }
      
      protected function clickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_isSeleted)
         {
            return;
         }
         if(_func != null)
         {
            _func(_info);
         }
         if(_selecetHander != null)
         {
            _selecetHander();
         }
         setSelectBtn(true);
         initTxt();
      }
      
      public function dispose() : void
      {
         removeEventListener("click",clickHander);
         ObjectUtils.disposeObject(_btn);
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         _btn = null;
         _func = null;
      }
   }
}
