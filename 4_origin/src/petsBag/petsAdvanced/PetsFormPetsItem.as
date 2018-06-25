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
      
      public function setInfo(id:int, info:PetsFormData) : void
      {
         var tip:* = null;
         _itemId = id;
         _info = info;
         _petsName.text = "";
         ObjectUtils.disposeAllChildren(_pet);
         if(info)
         {
            tip = {};
            tip.title = info.Name;
            tip.isActive = info.State == 1;
            tip.state = info.State == 1?LanguageMgr.GetTranslation("petsBag.form.petsWakeTxt"):LanguageMgr.GetTranslation("petsBag.form.petsUnWakeTxt");
            tip.activeValue = info.Name + LanguageMgr.GetTranslation("petsBag.form.petsWakeCard");
            tip.propertyValue = LanguageMgr.GetTranslation("petsBag.form.petsListGuardTxt",info.HeathUp) + "\n" + LanguageMgr.GetTranslation("petsBag.form.petsabsorbHurtTxt",info.DamageReduce);
            if(_info.TemplateID == 62023 || _info.TemplateID == 62024 || _info.TemplateID == 62020)
            {
               tip.getValue = LanguageMgr.GetTranslation("petsBag.form.petsCrypt.other");
            }
            else
            {
               tip.getValue = LanguageMgr.GetTranslation("petsBag.form.petsCrypt").toString().split(",")[id];
            }
            if(info.valid != null)
            {
               tip.valid = info.valid;
            }
            tipData = tip;
            showBtn = info.ShowBtn;
            _petsName.text = info.Name;
            if(_pet.numChildren == 0)
            {
               addPetBitmap(info.Appearance);
            }
         }
         else
         {
            showBtn = 0;
         }
      }
      
      public function addPetBitmap(path:String) : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.petsFormPath(path,showBtn == 3?2:1),0);
         loader.addEventListener("complete",__onComplete);
         LoadResourceManager.Instance.startLoad(loader,true);
      }
      
      protected function __onComplete(event:LoaderEvent) : void
      {
         var loader:BaseLoader = event.loader;
         loader.removeEventListener("complete",__onComplete);
         loader.content.x = -loader.content.width / 2;
         loader.content.y = -loader.content.height;
         ObjectUtils.disposeAllChildren(_pet);
      }
      
      protected function __onFollowClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendPetFollowOrCall(true,_info.TemplateID);
         SocketManager.Instance.out.sendUpdatePets(true,PlayerManager.Instance.Self.ID,_info.TemplateID);
      }
      
      protected function __onCallBackClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.sendPetFollowOrCall(false,_info.TemplateID);
         SocketManager.Instance.out.sendUpdatePets(false,PlayerManager.Instance.Self.ID,0);
      }
      
      protected function __onWakeClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var bagInfo:InventoryItemInfo = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(_info.TemplateID);
         if(bagInfo)
         {
            SocketManager.Instance.out.sendUsePetTemporaryCard(bagInfo.BagType,bagInfo.Place);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.notForm"));
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         if(_bg.getFrame < 2)
         {
            SoundManager.instance.playButtonSound();
            dispatchEvent(new PetItemEvent("itemclick",{"id":_itemId}));
         }
      }
      
      protected function __onMouseOut(event:MouseEvent) : void
      {
         setBtnVisible(false);
      }
      
      protected function __onMouseOver(event:MouseEvent) : void
      {
         setBtnVisible(true);
      }
      
      private function setBtnVisible(flag:Boolean) : void
      {
         if(_showBtnFlag == 1)
         {
            _followBtn.visible = flag;
         }
         else if(_showBtnFlag == 2)
         {
            _callBackBtn.visible = flag;
         }
         else if(_showBtnFlag == 3)
         {
            _wakeBtn.visible = flag;
         }
      }
      
      public function set showBtn(value:int) : void
      {
         _showBtnFlag = value;
         var _loc2_:Boolean = true;
         this.mouseEnabled = _loc2_;
         this.mouseChildren = _loc2_;
         _bg.setFrame(1);
         if(value == 1)
         {
            _callBackBtn.visible = false;
            _wakeBtn.visible = false;
         }
         else if(value == 2)
         {
            _followBtn.visible = false;
            _wakeBtn.visible = false;
         }
         else if(value == 3)
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
