package petsBag.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import pet.data.PetInfo;
   import petsBag.view.PetHappyBar;
   
   public class PetHappyTip extends BaseTip
   {
       
      
      private var _happyValueLbl:FilterFrameText;
      
      private var _happyValueTxt:FilterFrameText;
      
      private var _happyHeartLbl:FilterFrameText;
      
      private var _happyHeartTxt:FilterFrameText;
      
      private var _happyDesc:FilterFrameText;
      
      private var _splitImg:ScaleBitmapImage;
      
      protected var _bg:ScaleBitmapImage;
      
      private var _container:Sprite;
      
      private var _info:PetInfo;
      
      private var LEADING:int = 5;
      
      public function PetHappyTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         initView();
      }
      
      private function initView() : void
      {
         _happyValueLbl = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyTip.happyValueLbl");
         _happyValueLbl.text = LanguageMgr.GetTranslation("ddt.pets.petHapyyStatus");
         _happyValueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyTip.happyValueTxt");
         _happyHeartLbl = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyTip.happyHeartLbl");
         _happyHeartLbl.text = LanguageMgr.GetTranslation("ddt.pets.petHapyyheart");
         _happyHeartTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyTip.happyHeartTxt");
         _happyDesc = ComponentFactory.Instance.creatComponentByStylename("petsBag.petHappyTip.happyDesc");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _splitImg = ComponentFactory.Instance.creatComponentByStylename("petTips.line");
         _container = new Sprite();
         _container.addChild(_happyValueLbl);
         _container.addChild(_happyValueTxt);
         _container.addChild(_happyHeartLbl);
         _container.addChild(_happyHeartTxt);
         _container.addChild(_happyDesc);
         _container.addChild(_splitImg);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override public function set tipData(param1:Object) : void
      {
         _info = param1 as PetInfo;
         updateView();
      }
      
      override public function get tipData() : Object
      {
         return _info;
      }
      
      private function updateView() : void
      {
         if(_info == null)
         {
            return;
         }
         _happyValueTxt.text = happyPercent().toPrecision(3) + "%";
         _happyHeartTxt.text = getPetStatusArray()[_info.PetHappyStar];
         _happyDesc.text = _info.PetHappyStar > 0?LanguageMgr.GetTranslation("ddt.pets.petHappyDesc",PetHappyBar.petPercentArray[_info.PetHappyStar]):LanguageMgr.GetTranslation("ddt.pets.petUnFight");
         fixPos();
         _bg.width = _container.width + 10;
         _bg.height = _container.height + 20;
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function fixPos() : void
      {
         _happyValueTxt.x = _happyValueLbl.x + _happyValueLbl.textWidth + LEADING;
         _happyValueTxt.y = _happyValueLbl.y;
         _happyHeartLbl.x = _happyValueLbl.x;
         _happyHeartLbl.y = _happyValueLbl.y + _happyValueLbl.textHeight + LEADING;
         _happyHeartTxt.x = _happyHeartLbl.x + _happyHeartLbl.textWidth + LEADING;
         _happyHeartTxt.y = _happyHeartLbl.y;
         _splitImg.y = _happyHeartLbl.y + _happyHeartLbl.textHeight + LEADING * 2;
         _happyDesc.y = _splitImg.y + _splitImg.height + LEADING * 2;
         _happyDesc.x = _happyValueLbl.x;
      }
      
      private function getPetStatusArray() : Array
      {
         var _loc1_:Array = [];
         return LanguageMgr.GetTranslation("ddt.petsBag.petStatus").split("||");
      }
      
      private function happyPercent() : Number
      {
         var _loc1_:* = 0;
         if(_info)
         {
            _loc1_ = Number(_info.Hunger / 10000 * 100);
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         _info = null;
         if(_happyValueLbl)
         {
            ObjectUtils.disposeObject(_happyValueLbl);
            _happyValueLbl = null;
         }
         if(_happyValueTxt)
         {
            ObjectUtils.disposeObject(_happyValueTxt);
            _happyValueTxt = null;
         }
         if(_happyHeartLbl)
         {
            ObjectUtils.disposeObject(_happyHeartLbl);
            _happyHeartLbl = null;
         }
         if(_happyHeartTxt)
         {
            ObjectUtils.disposeObject(_happyHeartTxt);
            _happyHeartTxt = null;
         }
         if(_happyDesc)
         {
            ObjectUtils.disposeObject(_happyDesc);
            _happyDesc = null;
         }
         if(_splitImg)
         {
            ObjectUtils.disposeObject(_splitImg);
            _splitImg = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         super.dispose();
      }
   }
}
