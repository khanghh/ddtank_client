package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.SimpleItem;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class HorsePicCherishTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _typeItem:SimpleItem;
      
      protected var _title:FilterFrameText;
      
      protected var _valid:FilterFrameText;
      
      private var _rule:ScaleBitmapImage;
      
      private var _rule2:ScaleBitmapImage;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      private var _vBox:VBox;
      
      private var _itemVec:Vector.<HorsePicCherishTipItem>;
      
      public function HorsePicCherishTip()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.titleTxt");
         _valid = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
         _typeItem = ComponentFactory.Instance.creatComponentByStylename("core.goodTip.TypeItem");
         _rule = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _rule2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         addChild(_bg);
         addChild(_title);
         addChild(_typeItem);
         addChild(_rule);
         addChild(_rule2);
         addChild(_valid);
         _itemVec = new Vector.<HorsePicCherishTipItem>();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.vBox");
         _valid.x = _vBox.x;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new HorsePicCherishTipItem(_loc2_);
            _vBox.addChild(_loc1_);
            _itemVec.push(_loc1_);
            _loc2_++;
         }
         addChild(_vBox);
         PositionUtils.setPos(_typeItem,"horsePicCherish.typeItem.pos");
         PositionUtils.setPos(_rule,"hall.tip.rule.pos");
         PositionUtils.setPos(_rule2,"hall.tip.rule.pos");
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _data = param1;
            _loc4_ = _typeItem.foreItems[0] as FilterFrameText;
            _loc4_.text = _data["type"];
            _title.text = _data["title"];
            _itemVec[0].isActive = _data["isActive"];
            _itemVec[0].value = _data["state"];
            _itemVec[1].value = _data["activeValue"];
            _itemVec[2].value = _data["propertyValue"];
            _itemVec[3].value = _data["getValue"];
            if(isActivate())
            {
               if(Number(_data["valid"]) == 2147483647)
               {
                  _valid.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
                  _valid.textColor = 16776960;
               }
               else
               {
                  _loc3_ = _data["valid"] - TimeManager.Instance.Now().getTime();
                  _loc6_ = _loc3_ / 3600000;
                  _loc5_ = _loc3_ / 86400000;
                  _loc2_ = _loc3_ / 60000;
                  if(_loc2_ < 1)
                  {
                     _valid.text = LanguageMgr.GetTranslation("horse.tips.valid");
                  }
                  else if(_loc2_ < 60)
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerII",_loc2_);
                  }
                  else if(_loc6_ < 24)
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerI",_loc6_);
                  }
                  else
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timer",_loc5_);
                  }
                  _valid.textColor = 16777215;
               }
            }
            update();
         }
      }
      
      private function isActivate() : Boolean
      {
         return _data && _data["isActivate"] && _data.hasOwnProperty("valid");
      }
      
      private function update() : void
      {
         _vBox.arrange();
         _bg.width = _vBox.width + 20;
         _bg.height = _vBox.y + _vBox.height + 10;
         _rule.width = _bg.width - 10;
         if(isActivate())
         {
            var _loc1_:Boolean = true;
            _valid.visible = _loc1_;
            _rule2.visible = _loc1_;
            _rule2.y = _vBox.y + _vBox.height + 8;
            _valid.y = _rule2.y + 8;
            _bg.height = _valid.y + _valid.height + 10;
         }
         else
         {
            _bg.height = _vBox.y + _vBox.height + 10;
            _loc1_ = false;
            _valid.visible = _loc1_;
            _rule2.visible = _loc1_;
         }
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         _tipWidth = param1;
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_typeItem);
         _typeItem = null;
         ObjectUtils.disposeObject(_rule);
         _rule = null;
         ObjectUtils.disposeObject(_rule2);
         _rule2 = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_valid);
         _valid = null;
         var _loc3_:int = 0;
         var _loc2_:* = _itemVec;
         for each(var _loc1_ in _itemVec)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemVec = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
