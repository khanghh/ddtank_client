package farm.viewx.helper
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.viewx.shop.FarmShopView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import shop.view.ShopItemCell;
   
   public class HelperSetView extends Frame
   {
      
      private static const MaxNum:int = 50;
       
      
      private var _titleBg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _btmBg:ScaleBitmapImage;
      
      private var _ResetBtn:TextButton;
      
      private var _okBtn:TextButton;
      
      private var _Bg:ScaleBitmapImage;
      
      private var _SetBg:Scale9CornerImage;
      
      private var _SetBg1:Scale9CornerImage;
      
      private var _AddBtn:BaseButton;
      
      private var _AddBtn1:BaseButton;
      
      private var _MinusBtn:BaseButton;
      
      private var _MinusBtn1:BaseButton;
      
      private var _SetInputBg:Scale9CornerImage;
      
      private var _SetInputBg1:Scale9CornerImage;
      
      private var _setNumTxt:TextInput;
      
      private var _setNumTxt1:TextInput;
      
      private var _setNum:int = 0;
      
      private var _setFertilizerNum:int = 0;
      
      private var _NumerTxt:FilterFrameText;
      
      private var _NumerTxt1:FilterFrameText;
      
      private var _seedBtn:BaseButton;
      
      private var _FertilizerBtn:BaseButton;
      
      private var _seedSetBg:Bitmap;
      
      private var _fertilizerSetBg:Bitmap;
      
      private var _seedList:SeedSelect;
      
      private var _fertilizerList:FertilizerSelect;
      
      private var _result:ShopItemCell;
      
      private var _fertiliresult:ShopItemCell;
      
      private var _helperSetViewSelectResult:Function;
      
      private var _buyFrame:HelperBuyAlertFrame;
      
      private var seednum:int;
      
      private var manure:int;
      
      private var _farmShop:FarmShopView;
      
      private var _findNumState:Function;
      
      public function HelperSetView()
      {
         super();
         initView();
         addEvent();
         escEnable = true;
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("assets.farm.titleSmall");
         addToContent(_titleBg);
         PositionUtils.setPos(_titleBg,"farm.helperSettilte.Pos");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.farmShopPayPnlTitle");
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.farm.hepper.help.Set");
         addToContent(_titleTxt);
         PositionUtils.setPos(_titleTxt,"farm.helperSettilteTxt.Pos");
         _btmBg = ComponentFactory.Instance.creatComponentByStylename("asset.farmheler.btmBimap");
         addToContent(_btmBg);
         _ResetBtn = ComponentFactory.Instance.creatComponentByStylename("farm.helper.ResetBtn");
         _ResetBtn.text = LanguageMgr.GetTranslation("ddt.farm.hepper.help.Reset");
         addToContent(_ResetBtn);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("farm.helper.okBtn");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         addToContent(_okBtn);
         _Bg = ComponentFactory.Instance.creatComponentByStylename("asset.HelperSet.bg");
         addToContent(_Bg);
         _SetBg = ComponentFactory.Instance.creatComponentByStylename("asset.HelperSet.bgI");
         addToContent(_SetBg);
         _SetBg1 = ComponentFactory.Instance.creatComponentByStylename("asset.HelperSet.bgII");
         addToContent(_SetBg1);
         _AddBtn = ComponentFactory.Instance.creatComponentByStylename("helperSet.NumberAddBtn");
         addToContent(_AddBtn);
         _AddBtn1 = ComponentFactory.Instance.creatComponentByStylename("helperSet.NumberAddBtn");
         addToContent(_AddBtn1);
         PositionUtils.setPos(_AddBtn1,"farm.helperSetAddbtn.Pos");
         _MinusBtn = ComponentFactory.Instance.creatComponentByStylename("helperSet.NumberMinuesBtn");
         addToContent(_MinusBtn);
         _MinusBtn1 = ComponentFactory.Instance.creatComponentByStylename("helperSet.NumberMinuesBtn");
         addToContent(_MinusBtn1);
         PositionUtils.setPos(_MinusBtn1,"farm.helperSetMinues.Pos");
         _SetInputBg = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SetInputBg");
         addToContent(_SetInputBg);
         _SetInputBg1 = ComponentFactory.Instance.creatComponentByStylename("farm.helper.SetInputBg");
         addToContent(_SetInputBg1);
         PositionUtils.setPos(_SetInputBg1,"farm.helper.SetInputBg.Pos");
         _setNumTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.SetNumInput");
         addToContent(_setNumTxt);
         _setNumTxt.textField.restrict = "0-9";
         _setNumTxt1 = ComponentFactory.Instance.creatComponentByStylename("farm.text.SetNumInput");
         addToContent(_setNumTxt1);
         PositionUtils.setPos(_setNumTxt1,"farm.helper.SetInputTxt.Pos");
         _setNumTxt1.textField.restrict = "0-9";
         _setNum = 0;
         _setFertilizerNum = 0;
         _NumerTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.NumText");
         _NumerTxt1 = ComponentFactory.Instance.creatComponentByStylename("farm.text.NumText");
         var _loc3_:* = LanguageMgr.GetTranslation("tank.view.bagII.BreakGoodsView.num");
         _NumerTxt1.text = _loc3_;
         _NumerTxt.text = _loc3_;
         PositionUtils.setPos(_NumerTxt1,"farm.helper.NumberTxt.Pos");
         addToContent(_NumerTxt);
         addToContent(_NumerTxt1);
         _seedBtn = ComponentFactory.Instance.creatComponentByStylename("helperSet.SeedBtn");
         addToContent(_seedBtn);
         _FertilizerBtn = ComponentFactory.Instance.creatComponentByStylename("helperSet.FertilizerBtn");
         addToContent(_FertilizerBtn);
         _seedSetBg = ComponentFactory.Instance.creatBitmap("asset.farmHelper.SetBg1");
         _fertilizerSetBg = ComponentFactory.Instance.creatBitmap("asset.farmHelper.SetBg");
         _seedList = new SeedSelect();
         _fertilizerList = new FertilizerSelect();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215,0);
         _loc2_.graphics.drawRect(0,0,50,50);
         _loc2_.graphics.endFill();
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,50,50);
         _loc1_.graphics.endFill();
         _result = new ShopItemCell(_loc2_,null,false,true);
         _result.cellSize = 50;
         PositionUtils.setPos(_result,"farm.helper.cellPos");
         _seedBtn.addChild(_result);
         _seedBtn.mouseChildren = true;
         _fertiliresult = new ShopItemCell(_loc1_);
         _fertiliresult.cellSize = 50;
         PositionUtils.setPos(_fertiliresult,"farm.helper.cellPos");
         _FertilizerBtn.addChild(_fertiliresult);
         _FertilizerBtn.mouseChildren = true;
      }
      
      public function set helperSetViewSelectResult(param1:Function) : void
      {
         _helperSetViewSelectResult = param1;
      }
      
      public function update(param1:FilterFrameText, param2:FilterFrameText, param3:FilterFrameText, param4:FilterFrameText) : void
      {
         var _loc11_:int = 0;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc5_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         var _loc9_:Dictionary = new Dictionary();
         var _loc12_:Dictionary = new Dictionary();
         _loc11_ = 0;
         while(_loc11_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc11_];
            _loc9_[_loc7_.TemplateInfo.Name] = _loc7_.TemplateInfo.TemplateID;
            _loc11_++;
         }
         var _loc14_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         _loc10_ = 0;
         while(_loc10_ < _loc14_.length)
         {
            _loc6_ = _loc14_[_loc10_];
            _loc12_[_loc6_.TemplateInfo.Name] = _loc6_.TemplateInfo.TemplateID;
            _loc10_++;
         }
         var _loc13_:int = _loc9_[param1.text];
         var _loc8_:int = _loc12_[param3.text];
         _result.info = ItemManager.Instance.getTemplateById(_loc13_);
         _fertiliresult.info = ItemManager.Instance.getTemplateById(_loc8_);
         if(_result.info == null)
         {
            _AddBtn.enable = false;
            _MinusBtn.enable = false;
         }
         else
         {
            _AddBtn.enable = true;
            _MinusBtn.enable = true;
         }
         if(_fertiliresult.info == null)
         {
            _AddBtn1.enable = false;
            _MinusBtn1.enable = false;
         }
         else
         {
            _AddBtn1.enable = true;
            _MinusBtn1.enable = true;
         }
         _setNumTxt.text = param2.text;
         _setNum = int(param2.text);
         _setNumTxt1.text = param4.text;
         _setFertilizerNum = int(param4.text);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameHandler);
         _AddBtn.addEventListener("click",__selectNum);
         _AddBtn1.addEventListener("click",__selectNum);
         _MinusBtn.addEventListener("click",__selectNum);
         _MinusBtn1.addEventListener("click",__selectNum);
         _setNumTxt.addEventListener("change",__txtchange);
         _setNumTxt1.addEventListener("change",__txtchange1);
         _okBtn.addEventListener("click",__okHandler);
         _ResetBtn.addEventListener("click",__resetHandler);
         _seedBtn.addEventListener("click",__seedHandler);
         _FertilizerBtn.addEventListener("click",__fertiliHandler);
         _seedList.addEventListener("selectSeed",__setseed);
         _fertilizerList.addEventListener("selectFertilizer",__setfertilizer);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameHandler);
         _AddBtn.removeEventListener("click",__selectNum);
         _AddBtn1.removeEventListener("click",__selectNum);
         _MinusBtn.removeEventListener("click",__selectNum);
         _MinusBtn1.removeEventListener("click",__selectNum);
         _setNumTxt.removeEventListener("change",__txtchange);
         _setNumTxt1.removeEventListener("change",__txtchange1);
         _ResetBtn.removeEventListener("click",__resetHandler);
         _okBtn.removeEventListener("click",__okHandler);
         _seedBtn.removeEventListener("click",__seedHandler);
         _FertilizerBtn.removeEventListener("click",__fertiliHandler);
         _seedList.removeEventListener("selectSeed",__setseed);
         _fertilizerList.removeEventListener("selectFertilizer",__setfertilizer);
      }
      
      private function __txtchange(param1:Event) : void
      {
         _setNum = parseInt(_setNumTxt.text);
         checkInput();
      }
      
      private function __txtchange1(param1:Event) : void
      {
         _setFertilizerNum = parseInt(_setNumTxt1.text);
         checkInputOne();
      }
      
      private function __selectNum(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_AddBtn !== _loc2_)
         {
            if(_AddBtn1 !== _loc2_)
            {
               if(_MinusBtn !== _loc2_)
               {
                  if(_MinusBtn1 === _loc2_)
                  {
                     if(_setFertilizerNum < 1)
                     {
                        _setFertilizerNum == 1;
                     }
                     else
                     {
                        _setFertilizerNum = Number(_setFertilizerNum) - 1;
                     }
                     checkInputOne();
                  }
               }
               else
               {
                  if(_setNum < 1)
                  {
                     _setNum == 1;
                  }
                  else
                  {
                     _setNum = Number(_setNum) - 1;
                  }
                  checkInput();
               }
            }
            else
            {
               _setFertilizerNum = Number(_setFertilizerNum) + 1;
               checkInputOne();
            }
         }
         else
         {
            _setNum = Number(_setNum) + 1;
            checkInput();
         }
      }
      
      private function __resetHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _setNumTxt.text = "0";
         _setNumTxt1.text = "0";
         _setNum = 0;
         _setFertilizerNum = 0;
         if(_result.info)
         {
            _result.info = ItemManager.Instance.getTemplateById(0);
         }
         if(_fertiliresult.info)
         {
            _fertiliresult.info = ItemManager.Instance.getTemplateById(0);
         }
         _AddBtn.enable = false;
         _AddBtn1.enable = false;
         _MinusBtn.enable = false;
         _MinusBtn1.enable = false;
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         seednum = int(_setNumTxt.text);
         manure = int(_setNumTxt1.text);
         var _loc7_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc8_:InventoryItemInfo = null;
         var _loc4_:InventoryItemInfo = null;
         if(_result.info)
         {
            _loc8_ = FarmModelController.instance.model.findItemInfo(32,_result.info.TemplateID);
         }
         if(_fertiliresult.info)
         {
            _loc4_ = FarmModelController.instance.model.findItemInfo(33,_fertiliresult.info.TemplateID);
         }
         if(_loc8_)
         {
            if(_loc8_.CategoryID == 32 && _loc8_.Count < seednum)
            {
               buyAlert();
               return;
            }
            if(seednum == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helper.SetTxt3"));
               return;
            }
         }
         if(_loc8_ == null && seednum > 0)
         {
            buyAlert();
            return;
         }
         if(_loc4_ == null && manure > 0)
         {
            buyAlert();
            return;
         }
         if(_loc4_)
         {
            if(_loc4_.CategoryID == 33 && _loc4_.Count < manure)
            {
               buyAlert();
               return;
            }
            if(manure == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farm.helper.SetTxt4"));
               return;
            }
         }
         var _loc6_:Object = {};
         if(_result.info)
         {
            _loc7_ = true;
            _loc6_.seedId = _result.info.TemplateID;
            _loc6_.seedNum = seednum;
         }
         if(_fertiliresult.info)
         {
            _loc5_ = true;
            _loc6_.manureId = _fertiliresult.info.TemplateID;
            _loc6_.manureNum = manure;
         }
         _loc6_.isSeed = _loc7_;
         _loc6_.isManure = _loc5_;
         if(_findNumState != null)
         {
            _loc2_ = _loc6_.seedId;
            if(!_loc2_)
            {
               _loc2_ = 0;
            }
            _loc3_ = _loc6_.manureId;
            if(!_loc3_)
            {
               _loc3_ = 0;
            }
            if(_findNumState.call(this,_loc2_,_loc3_) > 0)
            {
               buyAlert();
               return;
            }
         }
         if(_helperSetViewSelectResult != null)
         {
            _helperSetViewSelectResult.call(this,_loc6_);
         }
         dispose();
      }
      
      private function buyAlert() : void
      {
         _buyFrame = ComponentFactory.Instance.creatComponentByStylename("farm.HelperBuyAlertFrame.confirmBuy");
         LayerManager.Instance.addToLayer(_buyFrame,3,true,1);
         _buyFrame.addEventListener("response",__onBuyResponse);
      }
      
      private function __onBuyResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _buyFrame.removeEventListener("response",__onBuyResponse);
         _buyFrame.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _farmShop = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopView.shop");
            _farmShop.addEventListener("response",__closeFarmShop);
            _farmShop.show();
            _buyFrame.dispose();
         }
      }
      
      private function __closeFarmShop(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _farmShop.removeEventListener("response",__closeFarmShop);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               ObjectUtils.disposeObject(_farmShop);
               _farmShop = null;
         }
      }
      
      public function get getTxtNum1() : int
      {
         return seednum;
      }
      
      public function get getTxtNum2() : int
      {
         return manure;
      }
      
      public function get getTxtId1() : int
      {
         var _loc1_:int = 0;
         if(_result && _result.info)
         {
            _loc1_ = _result.info.TemplateID;
         }
         return _loc1_;
      }
      
      public function get getTxtId2() : int
      {
         var _loc1_:int = 0;
         if(_fertiliresult && _fertiliresult.info)
         {
            _loc1_ = _fertiliresult.info.TemplateID;
         }
         return _loc1_;
      }
      
      private function checkInput() : void
      {
         if(_setNum < 1)
         {
            _setNum = 0;
         }
         else if(_setNum > 50)
         {
            _setNum = 50;
         }
         _setNumTxt.text = _setNum.toString();
      }
      
      private function checkInputOne() : void
      {
         if(_setFertilizerNum < 1)
         {
            _setFertilizerNum = 0;
         }
         else if(_setFertilizerNum > 50)
         {
            _setFertilizerNum = 50;
         }
         _setNumTxt1.text = _setFertilizerNum.toString();
      }
      
      private function __frameHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __seedHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Point = _seedBtn.localToGlobal(new Point(-100,-60));
         _seedList.x = _loc2_.x;
         _seedList.y = _loc2_.y;
         _seedList.setVisible = true;
      }
      
      private function __fertiliHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Point = _FertilizerBtn.localToGlobal(new Point(-100,60));
         _fertilizerList.x = _loc2_.x;
         _fertilizerList.y = _loc2_.y;
         _fertilizerList.setVisible = true;
      }
      
      private function __setseed(param1:SelectComposeItemEvent) : void
      {
         var _loc2_:int = param1.data.id;
         _result.info = ItemManager.Instance.getTemplateById(_loc2_);
         _AddBtn.enable = true;
         _MinusBtn.enable = true;
      }
      
      private function __setfertilizer(param1:SelectComposeItemEvent) : void
      {
         var _loc2_:int = param1.data.id;
         _fertiliresult.info = ItemManager.Instance.getTemplateById(_loc2_);
         _AddBtn1.enable = true;
         _MinusBtn1.enable = true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function set findNumState(param1:Function) : void
      {
         _findNumState = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
            _titleBg = null;
         }
         if(_SetBg)
         {
            ObjectUtils.disposeObject(_SetBg);
            _SetBg = null;
         }
         if(_SetBg1)
         {
            ObjectUtils.disposeObject(_SetBg1);
            _SetBg1 = null;
         }
         if(_AddBtn)
         {
            ObjectUtils.disposeObject(_AddBtn);
            _AddBtn = null;
         }
         if(_AddBtn1)
         {
            ObjectUtils.disposeObject(_AddBtn1);
            _AddBtn1 = null;
         }
         if(_MinusBtn)
         {
            ObjectUtils.disposeObject(_MinusBtn);
            _MinusBtn = null;
         }
         if(_MinusBtn1)
         {
            ObjectUtils.disposeObject(_MinusBtn1);
            _MinusBtn1 = null;
         }
         if(_SetInputBg)
         {
            ObjectUtils.disposeObject(_SetInputBg);
            _SetInputBg = null;
         }
         if(_SetInputBg1)
         {
            ObjectUtils.disposeObject(_SetInputBg1);
            _SetInputBg1 = null;
         }
         if(_setNumTxt)
         {
            ObjectUtils.disposeObject(_setNumTxt);
            _setNumTxt = null;
         }
         if(_setNumTxt1)
         {
            ObjectUtils.disposeObject(_setNumTxt1);
            _setNumTxt1 = null;
         }
         if(_NumerTxt)
         {
            ObjectUtils.disposeObject(_NumerTxt);
            _NumerTxt = null;
         }
         if(_NumerTxt1)
         {
            ObjectUtils.disposeObject(_NumerTxt1);
            _NumerTxt1 = null;
         }
         if(_seedBtn)
         {
            ObjectUtils.disposeObject(_seedBtn);
            _seedBtn = null;
         }
         if(_FertilizerBtn)
         {
            ObjectUtils.disposeObject(_FertilizerBtn);
            _FertilizerBtn = null;
         }
         if(_ResetBtn)
         {
            ObjectUtils.disposeObject(_ResetBtn);
            _ResetBtn = null;
         }
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
            _okBtn = null;
         }
         if(_btmBg)
         {
            ObjectUtils.disposeObject(_btmBg);
            _btmBg = null;
         }
         if(_helperSetViewSelectResult != null)
         {
            _helperSetViewSelectResult = null;
         }
         _findNumState = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
