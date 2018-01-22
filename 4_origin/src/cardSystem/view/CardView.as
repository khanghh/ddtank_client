package cardSystem.view
{
   import cardSystem.data.CardInfo;
   import cardSystem.view.cardBag.CardBagView;
   import cardSystem.view.cardEquip.CardEquipView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardView extends Sprite implements Disposeable
   {
       
      
      private var _cardEquip:CardEquipView;
      
      private var _cardBag:CardBagView;
      
      private var _playerInfo:PlayerInfo;
      
      private var _helpBtn:BaseButton;
      
      private var _helpFrame:Frame;
      
      private var _okBtn:TextButton;
      
      private var _content:Bitmap;
      
      public function CardView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cardEquip = ComponentFactory.Instance.creatCustomObject("cardEquipView");
         _cardBag = new CardBagView();
         PositionUtils.setPos(_cardBag,"CardBagListView.Pos");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.helpBtn");
         PositionUtils.setPos(_helpBtn,"cardView.helpBtnPos");
         addChild(_cardEquip);
         addChild(_cardBag);
         addChild(_helpBtn);
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         if(_playerInfo == param1)
         {
            return;
         }
         _playerInfo = param1;
         _cardEquip.playerInfo = param1;
      }
      
      private function initEvent() : void
      {
         _cardBag.addEventListener("dragStart",__dragStartHandler);
         _cardBag.addEventListener("dragStop",__dragStopHandler);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         _cardBag.removeEventListener("dragStart",__dragStartHandler);
         _cardBag.removeEventListener("dragStop",__dragStopHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __dragStartHandler(param1:CellEvent) : void
      {
         var _loc2_:CardInfo = param1.data as CardInfo;
         if(_loc2_.templateInfo.Property8 == "1")
         {
            _cardEquip.shineMain();
         }
         else
         {
            _cardEquip.shineVice();
         }
      }
      
      private function __dragStopHandler(param1:CellEvent) : void
      {
         _cardEquip.stopShine();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_cardEquip)
         {
            _cardEquip.dispose();
         }
         _cardEquip = null;
         if(_cardBag)
         {
            _cardBag.dispose();
         }
         _cardBag = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_helpFrame == null)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardView.helpFrame");
            _okBtn = ComponentFactory.Instance.creatComponentByStylename("UpGradeFrame.helpFrame.OK");
            PositionUtils.setPos(_okBtn,"cardView.okBtnPos");
            _content = ComponentFactory.Instance.creatBitmap("asset.cardSystem.help.content");
            _okBtn.text = LanguageMgr.GetTranslation("ok");
            _helpFrame.titleText = LanguageMgr.GetTranslation("ddt.cardSystem.cardView.explain");
            _helpFrame.addToContent(_okBtn);
            _helpFrame.addToContent(_content);
            _okBtn.addEventListener("click",__closeHelpFrame);
            _helpFrame.addEventListener("response",__helpFrameRespose);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      protected function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            disposeHelpFrame();
         }
      }
      
      private function disposeHelpFrame() : void
      {
         _helpFrame.removeEventListener("response",__helpFrameRespose);
         _okBtn.removeEventListener("click",__closeHelpFrame);
         _helpFrame.dispose();
         _okBtn = null;
         _content = null;
         _helpFrame = null;
      }
      
      protected function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         disposeHelpFrame();
      }
   }
}
