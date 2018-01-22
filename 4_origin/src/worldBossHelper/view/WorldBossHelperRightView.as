package worldBossHelper.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.ServerConfigInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldBossHelper.WorldBossHelperController;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.data.WorldBossHelperTypeData;
   
   public class WorldBossHelperRightView extends Sprite implements Disposeable
   {
       
      
      private var _disposeArr:Array;
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _buffTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _inputTxt:FilterFrameText;
      
      private var _buffNumTxt:FilterFrameText;
      
      private var _selectBtn1:SelectedCheckButton;
      
      private var _buybornTxt:FilterFrameText;
      
      private var _selectBtn2:SelectedCheckButton;
      
      private var _fightnowTxt:FilterFrameText;
      
      private var _selectBtn3:SelectedCheckButton;
      
      private var _startTxt:FilterFrameText;
      
      private var _selectBtn4:SelectedCheckButton;
      
      private var _startOnceTxt:FilterFrameText;
      
      private var _typeItemGroup1:SelectedButtonGroup;
      
      private var _typeItemGroup2:SelectedButtonGroup;
      
      private var _bitmapArr:Array;
      
      private var _numBg:Bitmap;
      
      private var _buffInputIcon:Bitmap;
      
      private var _selectBg1:Bitmap;
      
      private var _selectBg2:Bitmap;
      
      private var _minNum:int;
      
      private var _maxNum:int;
      
      private var _inputNum:int;
      
      private var _typeData:WorldBossHelperTypeData;
      
      public function WorldBossHelperRightView()
      {
         super();
         _minNum = 0;
         _maxNum = 20;
         _disposeArr = [];
         _bitmapArr = [];
         _typeItemGroup1 = new SelectedButtonGroup(true);
         _typeItemGroup2 = new SelectedButtonGroup();
         _typeData = WorldBossHelperController.Instance.data;
         initView();
         initEvent();
      }
      
      public function get typeData() : WorldBossHelperTypeData
      {
         if(_typeItemGroup1.selectIndex != -1)
         {
            if(_typeItemGroup1.selectedCount != 0)
            {
               _typeData.type = _typeItemGroup1.selectIndex + 1;
            }
            else
            {
               _typeData.type = 0;
            }
         }
         else
         {
            _typeData.type = 0;
         }
         _typeData.openType = _typeItemGroup2.selectIndex + 1;
         _typeData.buffNum = _inputNum;
         return _typeData;
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         _rightBg = ComponentFactory.Instance.creat("worldBossHelper.view.rightBg");
         addChild(_rightBg);
         _numBg = ComponentFactory.Instance.creat("worldBossHelper.buff");
         addChild(_numBg);
         _buffTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.buffText");
         _buffTxt.text = LanguageMgr.GetTranslation("worldbosshelper.buyBuff");
         addChild(_buffTxt);
         _buffInputIcon = ComponentFactory.Instance.creat("worldBossHelper.num");
         addChild(_buffInputIcon);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.NumberInputText");
         _inputTxt.restrict = "0-9";
         addChild(_inputTxt);
         _maxBtn = ComponentFactory.Instance.creat("worldBossHelper.view.maxBtn");
         addChild(_maxBtn);
         _selectBg1 = ComponentFactory.Instance.creat("worldBossHelper.frame1");
         addChild(_selectBg1);
         _selectBtn1 = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.buybornBtn");
         addChild(_selectBtn1);
         var _loc6_:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("WorldBossReviveMoney");
         if(_loc6_ && _loc6_.Value)
         {
            _loc4_ = _loc6_.Value;
         }
         else
         {
            _loc4_ = 10;
         }
         _buybornTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.descritionText");
         _buybornTxt.text = LanguageMgr.GetTranslation("worldbosshelper.buyborn",_loc4_);
         _buybornTxt.x = _selectBtn1.x + 20;
         _buybornTxt.y = _selectBtn1.y + 22;
         addChild(_buybornTxt);
         _selectBtn2 = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.fightnowBtn");
         addChild(_selectBtn2);
         var _loc3_:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("WorldBossFightMoney");
         if(_loc3_ && _loc3_.Value)
         {
            _loc5_ = _loc3_.Value;
         }
         else
         {
            _loc5_ = 12;
         }
         _fightnowTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.descritionText");
         _fightnowTxt.text = LanguageMgr.GetTranslation("worldbosshelper.fightnow",_loc5_);
         _fightnowTxt.x = _selectBtn2.x + 20;
         _fightnowTxt.y = _selectBtn2.y + 22;
         addChild(_fightnowTxt);
         _selectBg2 = ComponentFactory.Instance.creat("worldBossHelper.frame2");
         addChild(_selectBg2);
         _selectBtn3 = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.startOnceBtn");
         addChild(_selectBtn3);
         var _loc2_:ServerConfigInfo = ServerConfigManager.instance.findInfoByName("WorldBossAssistantFightMoney");
         if(_loc2_ && _loc2_.Value)
         {
            _loc1_ = _loc2_.Value;
         }
         else
         {
            _loc1_ = 10;
         }
         _startTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.descritionText");
         _startTxt.text = LanguageMgr.GetTranslation("worldbosshelper.startOnce",_loc1_);
         _startTxt.x = _selectBtn3.x + 20;
         _startTxt.y = _selectBtn3.y + 22;
         addChild(_startTxt);
         _selectBtn4 = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.startBtn");
         addChild(_selectBtn4);
         _typeItemGroup1.addSelectItem(_selectBtn1);
         _typeItemGroup1.addSelectItem(_selectBtn2);
         _typeItemGroup2.addSelectItem(_selectBtn3);
         _typeItemGroup2.addSelectItem(_selectBtn4);
         _startOnceTxt = ComponentFactory.Instance.creatComponentByStylename("worldBossHelper.view.descritionText");
         _startOnceTxt.text = LanguageMgr.GetTranslation("worldbosshelper.start",_loc1_);
         _startOnceTxt.x = _selectBtn4.x + 20;
         _startOnceTxt.y = _selectBtn4.y + 22;
         addChild(_startOnceTxt);
         _disposeArr.push(_rightBg,_buffTxt,_maxBtn,_inputTxt,_buffNumTxt,_selectBtn1,_buybornTxt,_selectBtn2,_fightnowTxt,_selectBtn3,_startTxt,_selectBtn4,_startOnceTxt);
         _bitmapArr.push(_numBg,_buffInputIcon,_selectBg1,_selectBg2);
      }
      
      public function setState() : void
      {
         _inputNum = _typeData.buffNum;
         _inputTxt.text = "" + _typeData.buffNum;
         _typeItemGroup1.selectIndex = _typeData.type - 1;
         _selectBtn1.selected = _typeData.type == 1;
         _selectBtn2.selected = _typeData.type == 2;
         _typeItemGroup2.selectIndex = _typeData.openType - 1;
         var _loc1_:* = !WorldBossHelperManager.Instance.helperOpen;
         _selectBtn4.enable = _loc1_;
         _loc1_ = _loc1_;
         _selectBtn3.enable = _loc1_;
         _loc1_ = _loc1_;
         _selectBtn2.enable = _loc1_;
         _loc1_ = _loc1_;
         _selectBtn1.enable = _loc1_;
         _maxBtn.enable = _loc1_;
         WorldBossHelperManager.Instance.isHelperOnlyOnce = _typeItemGroup2.selectIndex == 0;
         if(WorldBossHelperManager.Instance.helperOpen)
         {
            _inputTxt.mouseEnabled = false;
         }
         else
         {
            _inputTxt.mouseEnabled = true;
         }
      }
      
      private function initEvent() : void
      {
         _selectBtn1.addEventListener("change",__typeItemHandler);
         _selectBtn2.addEventListener("change",__typeItemHandler);
         _selectBtn3.addEventListener("change",__typeItemHandler);
         _selectBtn4.addEventListener("change",__typeItemHandler);
         _inputTxt.addEventListener("change",__inputHandler);
         _maxBtn.addEventListener("click",__maxBtnHandler);
         _selectBtn1.addEventListener("select",__chooseItemHandler);
         _selectBtn2.addEventListener("select",__chooseItemHandler);
      }
      
      protected function __typeItemHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __chooseItemHandler(param1:Event) : void
      {
         if(_selectBtn1.selected)
         {
            WorldBossHelperController.Instance.monkeyType = 1;
         }
         else if(_selectBtn2.selected)
         {
            WorldBossHelperController.Instance.monkeyType = 2;
         }
         else
         {
            WorldBossHelperController.Instance.monkeyType = 0;
         }
      }
      
      private function removeEvent() : void
      {
         _selectBtn1.removeEventListener("change",__typeItemHandler);
         _selectBtn2.removeEventListener("change",__typeItemHandler);
         _selectBtn3.removeEventListener("change",__typeItemHandler);
         _selectBtn4.removeEventListener("change",__typeItemHandler);
         _inputTxt.removeEventListener("change",__inputHandler);
         _maxBtn.removeEventListener("click",__maxBtnHandler);
         _selectBtn1.removeEventListener("select",__chooseItemHandler);
         _selectBtn2.removeEventListener("select",__chooseItemHandler);
      }
      
      protected function __inputHandler(param1:Event) : void
      {
         if(int(_inputTxt.text) < _minNum)
         {
            _inputTxt.text = "" + _minNum;
         }
         else if(int(_inputTxt.text) > _maxNum)
         {
            _inputTxt.text = "" + _maxNum;
         }
         _inputNum = int(_inputTxt.text);
         updateInputView();
      }
      
      protected function __maxBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputNum = 20;
         updateInputView();
      }
      
      private function updateInputView() : void
      {
         _inputTxt.text = "" + _inputNum;
         _typeData.buffNum = _inputNum;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         removeEvent();
         _typeItemGroup1 = null;
         _typeItemGroup2 = null;
         _loc2_ = 0;
         while(_loc2_ < _disposeArr.length)
         {
            if(_disposeArr[_loc2_])
            {
               _disposeArr[_loc2_].dispose();
               _disposeArr[_loc2_] = null;
            }
            _loc2_++;
         }
         _disposeArr = null;
         _loc1_ = 0;
         while(_loc1_ < _bitmapArr.length)
         {
            if(_bitmapArr[_loc1_])
            {
               (_bitmapArr[_loc1_] as Bitmap).bitmapData.dispose();
               _bitmapArr[_loc1_] = null;
            }
            _loc1_++;
         }
         _bitmapArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
