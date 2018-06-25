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
      
      public function LimitListItem(info:ActiveEventsInfo, func:Function, selecteHander:Function)
      {
         super();
         _info = info;
         _func = func;
         _selecetHander = selecteHander;
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
      
      public function setSelectBtn(bool:Boolean) : void
      {
         _isSeleted = bool;
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
         var str:* = "";
         var title:String = "· " + _info.Title;
         if(title.length > 8)
         {
            str = title.substr(0,8) + "...";
         }
         else
         {
            str = title;
         }
         return str;
      }
      
      public function initRightView() : Function
      {
         return _func(_info);
      }
      
      protected function clickHander(event:MouseEvent) : void
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
