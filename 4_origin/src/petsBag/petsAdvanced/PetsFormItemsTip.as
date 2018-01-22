package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PetsFormItemsTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _title:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      protected var _valid:FilterFrameText;
      
      private var _rule:ScaleBitmapImage;
      
      private var _rule2:ScaleBitmapImage;
      
      private var _itemVec:Vector.<PetsFormItemsTipItem>;
      
      public function PetsFormItemsTip()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsTip.bg");
         addChild(_bg);
         _title = ComponentFactory.Instance.creatComponentByStylename("petsBag.form.petsTip.titleTxt");
         addChild(_title);
         _rule = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _rule.width = _bg.width;
         addChild(_rule);
         PositionUtils.setPos(_rule,"hall.tip.rule.pos");
         _rule2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _rule2.width = _bg.width;
         addChild(_rule2);
         PositionUtils.setPos(_rule2,"hall.tip.rule.pos");
         _rule2.y = 130;
         _valid = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
         _valid.x = _title.x;
         _valid.y = 135;
         addChild(_valid);
         _itemVec = new Vector.<PetsFormItemsTipItem>();
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new PetsFormItemsTipItem(_loc2_);
            addChild(_loc1_);
            _itemVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _data = param1;
            _title.text = _data["title"];
            _itemVec[0].isActive = _data["isActive"];
            _itemVec[0].value = _data["state"];
            _itemVec[1].value = _data["activeValue"];
            _itemVec[2].value = _data["propertyValue"];
            _itemVec[3].value = _data["getValue"];
            if(isActivate())
            {
               if(_data.hasOwnProperty("valid"))
               {
                  _loc3_ = (_data["valid"] as Date).getTime() - TimeManager.Instance.Now().getTime();
                  _loc5_ = _loc3_ / 3600000;
                  _loc4_ = _loc3_ / 86400000;
                  _loc2_ = _loc3_ / 60000;
                  if(_loc2_ < 1)
                  {
                     _valid.text = LanguageMgr.GetTranslation("horse.tips.valid");
                  }
                  else if(_loc2_ < 60)
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerII");
                  }
                  else if(_loc5_ < 24)
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerI",_loc5_);
                  }
                  else
                  {
                     _valid.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timer",_loc4_);
                  }
                  _valid.textColor = 16777215;
               }
               else
               {
                  _valid.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
                  _valid.textColor = 16776960;
               }
            }
         }
         updateView();
      }
      
      private function updateView() : void
      {
         if(isActivate())
         {
            var _loc1_:Boolean = true;
            _valid.visible = _loc1_;
            _rule2.visible = _loc1_;
            _bg.height = 160;
         }
         else
         {
            _bg.height = 134;
            _loc1_ = false;
            _valid.visible = _loc1_;
            _rule2.visible = _loc1_;
         }
      }
      
      private function isActivate() : Boolean
      {
         return _data && _data["isActive"];
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
         ObjectUtils.disposeObject(_rule);
         _rule = null;
         ObjectUtils.disposeObject(_rule2);
         _rule2 = null;
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
