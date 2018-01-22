package ddt.view.caddyII.badLuck
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CaddyBadLuckView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Sprite;
      
      protected var _list:VBox;
      
      protected var _panel:ScrollPanel;
      
      private var _itemList:Vector.<BadLuckItem>;
      
      private var _dataList:Vector.<Object>;
      
      private var _timer:TimerJuggler;
      
      private var _Vline:MutipleImage;
      
      public function CaddyBadLuckView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creat("asset.caddy.badLuckBG");
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.sorttitleTxt");
         _loc3_.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.sortTitletxt");
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.NametitleTxt");
         _loc4_.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.nameTitletxt");
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.NumbertitleTxt");
         _loc1_.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.numberTitletxt");
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuckBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuckScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         _Vline = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.Vline");
         addChild(_bg);
         addChild(_loc3_);
         addChild(_loc4_);
         addChild(_loc1_);
         addChild(_panel);
         addChild(_Vline);
         _itemList = new Vector.<BadLuckItem>();
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("card.BadLuckItem",[_loc5_]);
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc5_++;
         }
         _panel.invalidateViewport();
         _dataList = new Vector.<Object>();
         _timer = TimerManager.getInstance().addTimerJuggler(1800000,-1);
         _timer.start();
         requestData();
      }
      
      private function initEvents() : void
      {
         _timer.addEventListener("timer",__oneTimer);
         RouletteManager.instance.addEventListener("update_badLuck",__getBadLuckHandler);
      }
      
      private function removeEvents() : void
      {
         _timer.removeEventListener("timer",__oneTimer);
         TimerManager.getInstance().removeJugglerByTimer(_timer);
         RouletteManager.instance.removeEventListener("update_badLuck",__getBadLuckHandler);
      }
      
      private function __oneTimer(param1:Event) : void
      {
         requestData();
      }
      
      private function requestData() : void
      {
         SocketManager.Instance.out.sendQequestBadLuck(true);
      }
      
      private function __getBadLuckHandler(param1:CaddyEvent) : void
      {
         _dataList = param1.dataList;
         updateData();
      }
      
      private function updateData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < 10 && _loc2_ < _dataList.length)
         {
            _loc1_ = _dataList[_loc2_];
            _itemList[_loc2_].update(_loc2_,_loc1_["Nickname"],_loc1_["Count"]);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _itemList;
         for each(var _loc1_ in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _dataList = null;
         _itemList = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(_Vline)
         {
            ObjectUtils.disposeObject(_Vline);
         }
         _Vline = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
