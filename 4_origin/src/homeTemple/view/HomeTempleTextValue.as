package homeTemple.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import homeTemple.HomeTempleController;
   import homeTemple.data.HomeTempleModel;
   
   public class HomeTempleTextValue extends Sprite implements Disposeable
   {
       
      
      private var _propertyVec:Vector.<FilterFrameText>;
      
      private var _propertyOffVec:Vector.<FilterFrameText>;
      
      private var _propertyPosVec:Array;
      
      public function HomeTempleTextValue()
      {
         _propertyPosVec = [PositionUtils.creatPoint("home.temple.levle.bloodTextPos"),PositionUtils.creatPoint("home.temple.levle.defenseTextPos"),PositionUtils.creatPoint("home.temple.levle.attackTextPos"),PositionUtils.creatPoint("home.temple.levle.luckyTextPos"),PositionUtils.creatPoint("home.temple.levle.resistanceTextPos"),PositionUtils.creatPoint("home.temple.levle.armorTextPos")];
         super();
         _propertyVec = new Vector.<FilterFrameText>();
         _propertyOffVec = new Vector.<FilterFrameText>();
         initView();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("home.temple.propertyText");
            addChild(_loc3_);
            _loc3_.text = "10000";
            _propertyVec.push(_loc3_);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("home.temple.propertyOffText");
            addChild(_loc1_);
            _loc1_.text = "+100";
            _propertyOffVec.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function setPropertyValue(param1:Boolean = false) : void
      {
         var _loc2_:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         var _loc3_:HomeTempleModel = HomeTempleController.Instance.getPracticeByLevel(_loc2_);
         var _loc6_:HomeTempleModel = HomeTempleController.Instance.getPracticeByLevel(_loc2_ + 1);
         var _loc5_:Array = [];
         _loc5_.push(_loc3_.Blood);
         _loc5_.push(_loc3_.Defence);
         _loc5_.push(_loc3_.Attack);
         _loc5_.push(_loc3_.Luck);
         _loc5_.push(_loc3_.MagicDefence);
         _loc5_.push(_loc3_.Guard);
         var _loc4_:Array = [0,0,0,0,0,0];
         if(param1 && _loc6_)
         {
            _loc4_[0] = _loc6_.Blood - _loc3_.Blood;
            _loc4_[1] = _loc6_.Defence - _loc3_.Defence;
            _loc4_[2] = _loc6_.Attack - _loc3_.Attack;
            _loc4_[3] = _loc6_.Luck - _loc3_.Luck;
            _loc4_[4] = _loc6_.MagicDefence - _loc3_.MagicDefence;
            _loc4_[5] = _loc6_.Guard - _loc3_.Guard;
         }
         setInfo(_loc5_,_loc4_);
      }
      
      private function setInfo(param1:Array, param2:Array) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _propertyVec[_loc3_].text = param1[_loc3_];
            _propertyOffVec[_loc3_].text = param2[_loc3_] > 0?"+" + param2[_loc3_]:"";
            _propertyVec[_loc3_].x = _propertyPosVec[_loc3_].x - (_propertyVec[_loc3_].width + _propertyOffVec[_loc3_].width) / 2;
            _propertyOffVec[_loc3_].x = _propertyVec[_loc3_].x + _propertyVec[_loc3_].width;
            var _loc4_:* = _propertyPosVec[_loc3_].y;
            _propertyOffVec[_loc3_].y = _loc4_;
            _propertyVec[_loc3_].y = _loc4_;
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _propertyVec.length)
         {
            ObjectUtils.disposeObject(_propertyVec[_loc2_]);
            _propertyVec[_loc2_] = null;
            _loc2_++;
         }
         _propertyVec = null;
         _loc1_ = 0;
         while(_loc1_ < _propertyOffVec.length)
         {
            ObjectUtils.disposeObject(_propertyOffVec[_loc1_]);
            _propertyOffVec[_loc1_] = null;
            _loc1_++;
         }
         _propertyOffVec = null;
      }
   }
}
