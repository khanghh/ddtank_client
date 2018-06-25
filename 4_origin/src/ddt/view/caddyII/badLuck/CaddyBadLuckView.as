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
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creat("asset.caddy.badLuckBG");
         var sortTitleTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.sorttitleTxt");
         sortTitleTxt.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.sortTitletxt");
         var NametitleTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.NametitleTxt");
         NametitleTxt.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.nameTitletxt");
         var NumbertitleTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.NumbertitleTxt");
         NumbertitleTxt.text = LanguageMgr.GetTranslation("ddt.caddy.badluck.numberTitletxt");
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuckBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuckScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         _Vline = ComponentFactory.Instance.creatComponentByStylename("caddy.badLuck.Vline");
         addChild(_bg);
         addChild(sortTitleTxt);
         addChild(NametitleTxt);
         addChild(NumbertitleTxt);
         addChild(_panel);
         addChild(_Vline);
         _itemList = new Vector.<BadLuckItem>();
         for(i = 0; i < 10; )
         {
            item = ComponentFactory.Instance.creatCustomObject("card.BadLuckItem",[i]);
            _list.addChild(item);
            _itemList.push(item);
            i++;
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
      
      private function __oneTimer(e:Event) : void
      {
         requestData();
      }
      
      private function requestData() : void
      {
         SocketManager.Instance.out.sendQequestBadLuck(true);
      }
      
      private function __getBadLuckHandler(e:CaddyEvent) : void
      {
         _dataList = e.dataList;
         updateData();
      }
      
      private function updateData() : void
      {
         var i:int = 0;
         var obj:* = null;
         i = 0;
         while(i < 10 && i < _dataList.length)
         {
            obj = _dataList[i];
            _itemList[i].update(i,obj["Nickname"],obj["Count"]);
            i++;
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _itemList;
         for each(var item in _itemList)
         {
            ObjectUtils.disposeObject(item);
            item = null;
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
