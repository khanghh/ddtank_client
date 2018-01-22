package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import petsBag.data.PetsFormData;
   import petsBag.event.PetItemEvent;
   
   public class PetsFormPetsItem extends Component implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _pet:Sprite;
      
      private var _petsName:FilterFrameText;
      
      private var _followBtn:TextButton;
      
      private var _wakeBtn:TextButton;
      
      private var _callBackBtn:TextButton;
      
      private var _showBtnFlag:int;
      
      private var _info:PetsFormData;
      
      private var _itemId:int;
      
      public function PetsFormPetsItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsBg");
         addChild(_bg);
         width = _bg.width;
         height = _bg.height;
         _pet = new Sprite();
         PositionUtils.setPos(_pet,"petsBag.form.petsPos");
         addChild(_pet);
         _petsName = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsNameTxt");
         addChild(_petsName);
         _followBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.followBtn");
         _followBtn.text = LanguageMgr.GetTranslation("petsBag.form.petsFollowTxt");
         _followBtn.visible = false;
         addChild(_followBtn);
         _wakeBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.followBtn");
         _wakeBtn.text = LanguageMgr.GetTranslation("petsBag.form.petsWakeTxt");
         _wakeBtn.visible = false;
         addChild(_wakeBtn);
         _callBackBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.callBackBtn");
         _callBackBtn.text = LanguageMgr.GetTranslation("ddt.pets.unfight");
         _callBackBtn.visible = false;
         addChild(_callBackBtn);
      }
      
      private function initEvent() : void
      {
         _followBtn.addEventListener("click",__onFollowClick);
         _wakeBtn.addEventListener("click",__onWakeClick);
         _callBackBtn.addEventListener("click",__onCallBackClick);
         addEventListener("click",__onMouseClick);
         addEventListener("mouseOver",__onMouseOver);
         addEventListener("mouseOut",__onMouseOut);
      }
      
      public function setInfo(param1:int, param2:PetsFormData) : void
      {
         var _loc3_:* = null;
         _itemId = param1;
         _info = param2;
         _petsName.text = "";
         ObjectUtils.disposeAllChildren(_pet);
         if(param2)
         {
            _loc3_ = {};
            _loc3_.title = param2.Name;
            _loc3_.isActive = param2.State == 1;
            _loc3_.state = param2.State == 1?LanguageMgr.GetTranslation("petsBag.form.petsWakeTxt"):LanguageMgr.GetTranslation("petsBag.form.petsUnWakeTxt");
            _loc3_.activeValue = param2.Name + LanguageMgr.GetTranslation("petsBag.form.petsWakeCard");
            _loc3_.propertyValue = LanguageMgr.GetTranslation("petsBag.form.petsListGuardTxt",param2.HeathUp) + "\n" + LanguageMgr.GetTranslation("petsBag.form.petsabsorbHurtTxt",param2.DamageReduce);
            _loc3_.getValue = LanguageMgr.GetTranslation("petsBag.form.petsCrypt").toString().split(",")[param1];
            if(param2.valid != null)
            {
               _loc3_.valid = param2.valid;
            }
            tipData = _loc3_;
            showBtn = param2.ShowBtn;
            _petsName.text = param2.Name;
            if(_pet.numChildren == 0)
            {
               addPetBitmap(param2.Appearance);
            }
         }
         else
         {
            showBtn = 0;
         }
      }
      
      public function addPetBitmap(param1:String) : void
      {
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.petsFormPath(param1,showBtn == 3?2:1),0);
         _loc2_.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(_loc2_,true);
      }
      
      protected function __onComplete(param1:LoaderEvent) : void
      {
         var _loc2_:BaseLoader = param1.loader;
         _loc2_.removeEventListener("complete",__onComplete);
         _loc2_.content.x = -_loc2_.content.width / 2;
         _loc2_.content.y = -_loc2_.content.height;
         ObjectUtils.disposeAllChildren(_pet);
      }
      
      protected function __onFollowClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendPetFollowOrCall(true,_info.TemplateID);
         SocketManager.Instance.out.sendUpdatePets(true,PlayerManager.Instance.Self.ID,_info.TemplateID);
      }
      
      protected function __onCallBackClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendPetFollowOrCall(false,_info.TemplateID);
         SocketManager.Instance.out.sendUpdatePets(false,PlayerManager.Instance.Self.ID,0);
      }
      
      protected function __onWakeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(_info.TemplateID);
         if(_loc2_)
         {
            SocketManager.Instance.out.sendUsePetTemporaryCard(_loc2_.BagType,_loc2_.Place);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.notForm"));
         }
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         if(_bg.getFrame < 2)
         {
            SoundManager.instance.playButtonSound();
            dispatchEvent(new PetItemEvent("itemclick",{"id":_itemId}));
         }
      }
      
      protected function __onMouseOut(param1:MouseEvent) : void
      {
         setBtnVisible(false);
      }
      
      protected function __onMouseOver(param1:MouseEvent) : void
      {
         setBtnVisible(true);
      }
      
      private function setBtnVisible(param1:Boolean) : void
      {
         if(_showBtnFlag == 1)
         {
            _followBtn.visible = param1;
         }
         else if(_showBtnFlag == 2)
         {
            _callBackBtn.visible = param1;
         }
         else if(_showBtnFlag == 3)
         {
            _wakeBtn.visible = param1;
         }
      }
      
      public function set showBtn(param1:int) : void
      {
         _showBtnFlag = param1;
         var _loc2_:Boolean = true;
         this.mouseEnabled = _loc2_;
         this.mouseChildren = _loc2_;
         _bg.setFrame(1);
         if(param1 == 1)
         {
            _callBackBtn.visible = false;
            _wakeBtn.visible = false;
         }
         else if(param1 == 2)
         {
            _followBtn.visible = false;
            _wakeBtn.visible = false;
         }
         else if(param1 == 3)
         {
            _followBtn.visible = false;
            _callBackBtn.visible = false;
         }
         else
         {
            _callBackBtn.visible = false;
            _followBtn.visible = false;
            _wakeBtn.visible = false;
            _bg.setFrame(2);
            _loc2_ = false;
            this.mouseEnabled = _loc2_;
            this.mouseChildren = _loc2_;
         }
      }
      
      public function get showBtn() : int
      {
         return _showBtnFlag;
      }
      
      private function removeEvent() : void
      {
         _followBtn.removeEventListener("click",__onFollowClick);
         _wakeBtn.removeEventListener("click",__onWakeClick);
         _callBackBtn.removeEventListener("click",__onCallBackClick);
         removeEventListener("click",__onMouseClick);
         removeEventListener("mouseOver",__onMouseOver);
         removeEventListener("mouseOut",__onMouseOut);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_petsName);
         _petsName = null;
         ObjectUtils.disposeObject(_followBtn);
         _followBtn = null;
         ObjectUtils.disposeObject(_wakeBtn);
         _wakeBtn = null;
         ObjectUtils.disposeObject(_callBackBtn);
         _callBackBtn = null;
         if(_pet)
         {
            ObjectUtils.disposeAllChildren(_pet);
            ObjectUtils.disposeObject(_pet);
            _pet = null;
         }
         _info = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function get info() : PetsFormData
      {
         return _info;
      }
   }
}
