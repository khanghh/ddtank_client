package ddt.view.qqTips
{
   import calendar.CalendarManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DesktopManager;
   import ddt.manager.PathManager;
   import ddt.manager.QQtipsManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import times.TimesManager;
   
   public class QQTipsView extends Sprite implements Disposeable
   {
       
      
      private var _qqInfo:QQTipsInfo;
      
      private var _bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _titleTxt:FilterFrameText;
      
      private var _outUrlTxt:TextField;
      
      protected var _moveRect:Sprite;
      
      private var _linkBtn:BaseButton;
      
      public function QQTipsView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.core.QQtipsBG");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("coreIconQQ.closebt");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("coreIconQQ.titleTxt");
         _linkBtn = ComponentFactory.Instance.creatComponentByStylename("coreIconQQ.linkbutton");
         _linkBtn.buttonMode = true;
         _outUrlTxt = ComponentFactory.Instance.creatCustomObject("coreIconQQ.QQOutUrlTxt");
         _outUrlTxt.defaultTextFormat = ComponentFactory.Instance.model.getSet("coreIconQQ.qq.outTF");
         _moveRect = new Sprite();
         addChild(_bg);
         addChild(_closeBtn);
         addChild(_titleTxt);
         addChild(_linkBtn);
         addChild(_outUrlTxt);
         addChild(_moveRect);
      }
      
      private function initEvents() : void
      {
         _closeBtn.addEventListener("click",__colseClick);
         _moveRect.addEventListener("mouseDown",__onFrameMoveStart);
         _linkBtn.addEventListener("click",__onLinkBtnClicked);
         QQtipsManager.instance.addEventListener("Close_QQ_tipsView",__CloseView);
         StageReferance.stage.addEventListener("keyDown",__onKeyDown);
      }
      
      private function remvoeEvents() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__colseClick);
         }
         if(_moveRect)
         {
            _moveRect.removeEventListener("mouseDown",__onFrameMoveStart);
         }
         _linkBtn.removeEventListener("click",__onLinkBtnClicked);
         QQtipsManager.instance.removeEventListener("Close_QQ_tipsView",__CloseView);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
      }
      
      private function __colseClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      private function __CloseView(e:Event) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function __onKeyDown(event:KeyboardEvent) : void
      {
         var focusTarget:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(DisplayUtils.isTargetOrContain(focusTarget,this))
         {
            if(event.keyCode == 27)
            {
               SoundManager.instance.play("008");
               ObjectUtils.disposeObject(this);
            }
         }
      }
      
      protected function __onFrameMoveStart(event:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("mouseMove",__onMoveWindow);
         StageReferance.stage.addEventListener("mouseUp",__onFrameMoveStop);
         startDrag();
      }
      
      protected function __onFrameMoveStop(event:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("mouseUp",__onFrameMoveStop);
         StageReferance.stage.removeEventListener("mouseMove",__onMoveWindow);
         stopDrag();
      }
      
      protected function __onMoveWindow(event:MouseEvent) : void
      {
         if(DisplayUtils.isInTheStage(new Point(event.localX,event.localY),this))
         {
            event.updateAfterEvent();
         }
         else
         {
            __onFrameMoveStop(null);
         }
      }
      
      public function set qqInfo(value:QQTipsInfo) : void
      {
         _qqInfo = value;
         _titleTxt.text = _qqInfo.title;
         var url:String = "<a href=\"event:clicktype:" + _qqInfo.outInType + "\">" + _qqInfo.content + "</a>";
         _outUrlTxt.htmlText = url;
      }
      
      private function __onLinkBtnClicked(evt:MouseEvent) : void
      {
         var req:URLRequest = new URLRequest(PathManager.solveRequestPath("LogClickTip.ashx"));
         var toServerData:URLVariables = new URLVariables();
         toServerData["title"] = qqInfo.title;
         req.data = toServerData;
         var loader:URLLoader = new URLLoader(req);
         loader.load(req);
         loader.addEventListener("ioError",onIOError);
         if(qqInfo.outInType == 0)
         {
            __playINmoudle();
         }
         else
         {
            SoundManager.instance.play("008");
            gotoPage(qqInfo.url);
         }
         ObjectUtils.disposeObject(this);
      }
      
      private function onIOError(e:IOErrorEvent) : void
      {
      }
      
      private function __playINmoudle() : void
      {
         if(qqInfo.outInType == 0)
         {
            if(qqInfo.moduleType == 1)
            {
               TimesManager.Instance.showByQQtips(qqInfo.inItemID);
            }
            else if(qqInfo.moduleType == 2)
            {
               CalendarManager.getInstance().qqOpen(qqInfo.inItemID);
            }
            else if(qqInfo.moduleType == 3)
            {
               QQtipsManager.instance.gotoShop(qqInfo.inItemID);
            }
         }
      }
      
      private function gotoPage(url:String) : void
      {
         var redirictURL:* = null;
         if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
         {
            redirictURL = "function redict () {window.open(\"" + url + "\", \"_blank\")}";
            ExternalInterface.call(redirictURL);
         }
         else
         {
            navigateToURL(new URLRequest(encodeURI(url)),"_blank");
         }
      }
      
      public function get qqInfo() : QQTipsInfo
      {
         return _qqInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,false);
         StageReferance.stage.focus = this;
      }
      
      public function set moveRect(value:String) : void
      {
         var arr:Array = value.split(",");
         _moveRect.graphics.clear();
         _moveRect.graphics.beginFill(0,0);
         _moveRect.graphics.drawRect(arr[0],arr[1],arr[2],arr[3]);
         _moveRect.graphics.endFill();
      }
      
      public function dispose() : void
      {
         remvoeEvents();
         _qqInfo = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_closeBtn)
         {
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_linkBtn)
         {
            ObjectUtils.disposeObject(_linkBtn);
         }
         _linkBtn = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_outUrlTxt)
         {
            ObjectUtils.disposeObject(_outUrlTxt);
         }
         _outUrlTxt = null;
         if(_moveRect)
         {
            ObjectUtils.disposeObject(_moveRect);
         }
         _moveRect = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         QQtipsManager.instance.isShowTipNow = false;
      }
   }
}
