package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AvatarCollectionMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _rightView:AvatarCollectionRightView;
      
      private var _canActivitySCB:SelectedCheckButton;
      
      private var _canBuySCB:SelectedCheckButton;
      
      private var _btnHelp:BaseButton;
      
      private var _leftView:AvatarCollectionLeftView;
      
      public function AvatarCollectionMainView()
      {
         super();
         this.x = 12;
         this.y = 53;
         AvatarCollectionManager.instance.initShopItemInfoList();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.avatarCollMainView.bg");
         _rightView = new AvatarCollectionRightView();
         PositionUtils.setPos(_rightView,"avatarColl.mainView.rightViewPos");
         _leftView = new AvatarCollectionLeftView(_rightView);
         PositionUtils.setPos(_leftView,"avatarColl.mainView.leftViewPos");
         _canActivitySCB = ComponentFactory.Instance.creatComponentByStylename("avatarColl.canActivitySCB");
         _canBuySCB = ComponentFactory.Instance.creatComponentByStylename("avatarColl.canBuySCB");
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"cardSystem.texpSystem.btnHelp",{
            "x":728,
            "y":-92
         },LanguageMgr.GetTranslation("avatarCollection.helpTxt"),"avatarColl.help.content",408,488);
         addChild(_bg);
         addChild(_canActivitySCB);
         addChild(_canBuySCB);
         addChild(_leftView);
         addChild(_rightView);
      }
      
      private function initEvent() : void
      {
         _canActivitySCB.addEventListener("click",canActivityChangeHandler,false,0,true);
         _canBuySCB.addEventListener("click",canBuyChangeHandler,false,0,true);
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         if(_canBuySCB.selected)
         {
            _canBuySCB.selected = false;
            _loc1_ = "isBuyFilter";
         }
         else if(_canActivitySCB.selected)
         {
            _canActivitySCB.selected = false;
            _loc1_ = "isFilter";
         }
         if(_loc1_ != null)
         {
            _leftView.reset(_loc1_);
         }
      }
      
      private function canBuyChangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _leftView.canBuyChange(_canBuySCB.selected);
         if(_canBuySCB.selected)
         {
            AvatarCollectionManager.instance.selectAllClicked(false);
            AvatarCollectionManager.instance.listState("canBuy");
            _canActivitySCB.selected = false;
         }
         else
         {
            AvatarCollectionManager.instance.listState("normal");
         }
      }
      
      private function canActivityChangeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _leftView.canActivityChange(_canActivitySCB.selected);
         if(_canActivitySCB.selected)
         {
            AvatarCollectionManager.instance.selectAllClicked(false);
            AvatarCollectionManager.instance.listState("canActivity");
            _canBuySCB.selected = false;
         }
         else
         {
            AvatarCollectionManager.instance.listState("normal");
         }
      }
      
      private function removeEvent() : void
      {
         _canActivitySCB.removeEventListener("click",canActivityChangeHandler);
         _canBuySCB.removeEventListener("click",canBuyChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _leftView = null;
         _rightView = null;
         _canActivitySCB = null;
         _canBuySCB = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get unitList() : Vector.<AvatarCollectionUnitView>
      {
         return _leftView.unitList;
      }
   }
}
