package treasureHunting.views
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.InventoryItemAnalyzer;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasureHunting.TreasureControl;
   import treasureHunting.TreasureManager;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class TreasureEnterView extends Sprite implements IRightView
   {
       
      
      private var _content:Sprite;
      
      private var _enterBG:Bitmap;
      
      private var _enterBtn:SimpleBitmapButton;
      
      private var _remain:FilterFrameText;
      
      private var _treasureFrame:TreasureHuntingFrame;
      
      public function TreasureEnterView()
      {
         super();
         TreasureControl.instance.loadTreasureHuntingModule(init2);
      }
      
      public function init() : void
      {
      }
      
      private function init2() : void
      {
         initView();
         initTimer();
         initEvent();
      }
      
      private function initView() : void
      {
         _content = new Sprite();
         PositionUtils.setPos(_content,"treasureHunting.Treasure.ContentPos");
         _enterBG = ComponentFactory.Instance.creat("treasureHunting.enterBG");
         _content.addChild(_enterBG);
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.enterBtn");
         _content.addChild(_enterBtn);
         _remain = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.remainDayTxt");
         _content.addChild(_remain);
         addChild(_content);
      }
      
      private function initTimer() : void
      {
         treasureTimerHandler();
         WonderfulActivityManager.Instance.addTimerFun("treasure",treasureTimerHandler);
      }
      
      private function treasureTimerHandler() : void
      {
         var endDate:Date = TreasureManager.instance.endDate;
         var nowDate:Date = TimeManager.Instance.Now();
         var str:String = WonderfulActivityManager.Instance.getTimeDiff(endDate,nowDate);
         if(_remain)
         {
            _remain.text = str;
         }
         if(str == "0")
         {
            if(_remain)
            {
               _remain.text = LanguageMgr.GetTranslation("treasureHunting.over");
            }
            SocketManager.Instance.out.sendInitTreasueHunting();
            WonderfulActivityManager.Instance.delTimerFun("treasure");
         }
      }
      
      private function initEvent() : void
      {
         if(_enterBtn)
         {
            _enterBtn.addEventListener("click",onEnterBtnClick);
         }
      }
      
      protected function onEnterBtnClick(event:MouseEvent) : void
      {
         if(RouletteManager.instance.goodList == null)
         {
            LoadResourceManager.Instance.startLoad(LoaderCreate.Instance.creatRouletteTempleteLoader(loadComplete));
            return;
         }
         _treasureFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(_treasureFrame,3,false,1,false);
      }
      
      private function loadComplete(analyze:InventoryItemAnalyzer) : void
      {
         RouletteManager.instance.goodList = analyze.list;
         _treasureFrame = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.TreasureHuntingFrame");
         LayerManager.Instance.addToLayer(_treasureFrame,3,false,1,false);
      }
      
      private function removeEvent() : void
      {
         if(_enterBtn)
         {
            _enterBtn.removeEventListener("click",onEnterBtnClick);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         WonderfulActivityManager.Instance.delTimerFun("treasure");
         if(_enterBG)
         {
            ObjectUtils.disposeObject(_enterBG);
         }
         _enterBG = null;
         if(_enterBtn)
         {
            ObjectUtils.disposeObject(_enterBtn);
         }
         _enterBtn = null;
         if(_remain)
         {
            ObjectUtils.disposeObject(_remain);
         }
         _remain = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function setState(type:int, id:int) : void
      {
      }
   }
}
