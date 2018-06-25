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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,50,50);
         sp.graphics.endFill();
         var sp1:Sprite = new Sprite();
         sp1.graphics.beginFill(16777215,0);
         sp1.graphics.drawRect(0,0,50,50);
         sp1.graphics.endFill();
         _result = new ShopItemCell(sp,null,false,true);
         _result.cellSize = 50;
         PositionUtils.setPos(_result,"farm.helper.cellPos");
         _seedBtn.addChild(_result);
         _seedBtn.mouseChildren = true;
         _fertiliresult = new ShopItemCell(sp1);
         _fertiliresult.cellSize = 50;
         PositionUtils.setPos(_fertiliresult,"farm.helper.cellPos");
         _FertilizerBtn.addChild(_fertiliresult);
         _FertilizerBtn.mouseChildren = true;
      }
      
      public function set helperSetViewSelectResult(value:Function) : void
      {
         _helperSetViewSelectResult = value;
      }
      
      public function update(seedName:FilterFrameText, seednum:FilterFrameText, ferName:FilterFrameText, ferNum:FilterFrameText) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var k:int = 0;
         var itemInfo1:* = null;
         var arr:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         var _seedInfos:Dictionary = new Dictionary();
         var _fertilizerInfos:Dictionary = new Dictionary();
         for(i = 0; i < arr.length; )
         {
            itemInfo = arr[i];
            _seedInfos[itemInfo.TemplateInfo.Name] = itemInfo.TemplateInfo.TemplateID;
            i++;
         }
         var arr1:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(89);
         for(k = 0; k < arr1.length; )
         {
            itemInfo1 = arr1[k];
            _fertilizerInfos[itemInfo1.TemplateInfo.Name] = itemInfo1.TemplateInfo.TemplateID;
            k++;
         }
         var SeedId:int = _seedInfos[seedName.text];
         var fertilizerId:int = _fertilizerInfos[ferName.text];
         _result.info = ItemManager.Instance.getTemplateById(SeedId);
         _fertiliresult.info = ItemManager.Instance.getTemplateById(fertilizerId);
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
         _setNumTxt.text = seednum.text;
         _setNum = int(seednum.text);
         _setNumTxt1.text = ferNum.text;
         _setFertilizerNum = int(ferNum.text);
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
      
      private function __txtchange(event:Event) : void
      {
         _setNum = parseInt(_setNumTxt.text);
         checkInput();
      }
      
      private function __txtchange1(event:Event) : void
      {
         _setFertilizerNum = parseInt(_setNumTxt1.text);
         checkInputOne();
      }
      
      private function __selectNum(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
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
      
      private function __resetHandler(event:MouseEvent) : void
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
      
      private function __okHandler(evnet:MouseEvent) : void
      {
         var seedId:* = null;
         var manureId:* = null;
         SoundManager.instance.play("008");
         seednum = int(_setNumTxt.text);
         manure = int(_setNumTxt1.text);
         var isSetSeed:Boolean = false;
         var isSetManure:Boolean = false;
         var seedinfo:InventoryItemInfo = null;
         var fertilizerinfo:InventoryItemInfo = null;
         if(_result.info)
         {
            seedinfo = FarmModelController.instance.model.findItemInfo(32,_result.info.TemplateID);
         }
         if(_fertiliresult.info)
         {
            fertilizerinfo = FarmModelController.instance.model.findItemInfo(33,_fertiliresult.info.TemplateID);
         }
         if(seedinfo)
         {
            if(seedinfo.CategoryID == 32 && seedinfo.Count < seednum)
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
         if(seedinfo == null && seednum > 0)
         {
            buyAlert();
            return;
         }
         if(fertilizerinfo == null && manure > 0)
         {
            buyAlert();
            return;
         }
         if(fertilizerinfo)
         {
            if(fertilizerinfo.CategoryID == 33 && fertilizerinfo.Count < manure)
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
         var obj:Object = {};
         if(_result.info)
         {
            isSetSeed = true;
            obj.seedId = _result.info.TemplateID;
            obj.seedNum = seednum;
         }
         if(_fertiliresult.info)
         {
            isSetManure = true;
            obj.manureId = _fertiliresult.info.TemplateID;
            obj.manureNum = manure;
         }
         obj.isSeed = isSetSeed;
         obj.isManure = isSetManure;
         if(_findNumState != null)
         {
            seedId = obj.seedId;
            if(!seedId)
            {
               seedId = 0;
            }
            manureId = obj.manureId;
            if(!manureId)
            {
               manureId = 0;
            }
            if(_findNumState.call(this,seedId,manureId) > 0)
            {
               buyAlert();
               return;
            }
         }
         if(_helperSetViewSelectResult != null)
         {
            _helperSetViewSelectResult.call(this,obj);
         }
         dispose();
      }
      
      private function buyAlert() : void
      {
         _buyFrame = ComponentFactory.Instance.creatComponentByStylename("farm.HelperBuyAlertFrame.confirmBuy");
         LayerManager.Instance.addToLayer(_buyFrame,3,true,1);
         _buyFrame.addEventListener("response",__onBuyResponse);
      }
      
      private function __onBuyResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _buyFrame.removeEventListener("response",__onBuyResponse);
         _buyFrame.dispose();
         if(event.responseCode == 2 || event.responseCode == 3)
         {
            _farmShop = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopView.shop");
            _farmShop.addEventListener("response",__closeFarmShop);
            _farmShop.show();
            _buyFrame.dispose();
         }
      }
      
      private function __closeFarmShop(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _farmShop.removeEventListener("response",__closeFarmShop);
         switch(int(event.responseCode))
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
         var id:int = 0;
         if(_result && _result.info)
         {
            id = _result.info.TemplateID;
         }
         return id;
      }
      
      public function get getTxtId2() : int
      {
         var id:int = 0;
         if(_fertiliresult && _fertiliresult.info)
         {
            id = _fertiliresult.info.TemplateID;
         }
         return id;
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
      
      private function __frameHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __seedHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var pos:Point = _seedBtn.localToGlobal(new Point(-100,-60));
         _seedList.x = pos.x;
         _seedList.y = pos.y;
         _seedList.setVisible = true;
      }
      
      private function __fertiliHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var pos:Point = _FertilizerBtn.localToGlobal(new Point(-100,60));
         _fertilizerList.x = pos.x;
         _fertilizerList.y = pos.y;
         _fertilizerList.setVisible = true;
      }
      
      private function __setseed(event:SelectComposeItemEvent) : void
      {
         var templateId:int = event.data.id;
         _result.info = ItemManager.Instance.getTemplateById(templateId);
         _AddBtn.enable = true;
         _MinusBtn.enable = true;
      }
      
      private function __setfertilizer(event:SelectComposeItemEvent) : void
      {
         var templateId:int = event.data.id;
         _fertiliresult.info = ItemManager.Instance.getTemplateById(templateId);
         _AddBtn1.enable = true;
         _MinusBtn1.enable = true;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function set findNumState(value:Function) : void
      {
         _findNumState = value;
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
