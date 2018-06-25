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
         var i:int = 0;
         var propertyText:* = null;
         var j:int = 0;
         var propertyOffText:* = null;
         for(i = 0; i < 6; )
         {
            propertyText = ComponentFactory.Instance.creatComponentByStylename("home.temple.propertyText");
            addChild(propertyText);
            propertyText.text = "10000";
            _propertyVec.push(propertyText);
            i++;
         }
         for(j = 0; j < 6; )
         {
            propertyOffText = ComponentFactory.Instance.creatComponentByStylename("home.temple.propertyOffText");
            addChild(propertyOffText);
            propertyOffText.text = "+100";
            _propertyOffVec.push(propertyOffText);
            j++;
         }
      }
      
      public function setPropertyValue(isShowOff:Boolean = false) : void
      {
         var level:int = HomeTempleController.Instance.currentInfo.CurrentLevel;
         var currentLevelModel:HomeTempleModel = HomeTempleController.Instance.getPracticeByLevel(level);
         var nextLevelModel:HomeTempleModel = HomeTempleController.Instance.getPracticeByLevel(level + 1);
         var value:Array = [];
         value.push(currentLevelModel.Blood);
         value.push(currentLevelModel.Defence);
         value.push(currentLevelModel.Attack);
         value.push(currentLevelModel.Luck);
         value.push(currentLevelModel.MagicDefence);
         value.push(currentLevelModel.Guard);
         var off:Array = [0,0,0,0,0,0];
         if(isShowOff && nextLevelModel)
         {
            off[0] = nextLevelModel.Blood - currentLevelModel.Blood;
            off[1] = nextLevelModel.Defence - currentLevelModel.Defence;
            off[2] = nextLevelModel.Attack - currentLevelModel.Attack;
            off[3] = nextLevelModel.Luck - currentLevelModel.Luck;
            off[4] = nextLevelModel.MagicDefence - currentLevelModel.MagicDefence;
            off[5] = nextLevelModel.Guard - currentLevelModel.Guard;
         }
         setInfo(value,off);
      }
      
      private function setInfo(value:Array, off:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < 6; )
         {
            _propertyVec[i].text = value[i];
            _propertyOffVec[i].text = off[i] > 0?"+" + off[i]:"";
            _propertyVec[i].x = _propertyPosVec[i].x - (_propertyVec[i].width + _propertyOffVec[i].width) / 2;
            _propertyOffVec[i].x = _propertyVec[i].x + _propertyVec[i].width;
            var _loc4_:* = _propertyPosVec[i].y;
            _propertyOffVec[i].y = _loc4_;
            _propertyVec[i].y = _loc4_;
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < _propertyVec.length; )
         {
            ObjectUtils.disposeObject(_propertyVec[i]);
            _propertyVec[i] = null;
            i++;
         }
         _propertyVec = null;
         for(j = 0; j < _propertyOffVec.length; )
         {
            ObjectUtils.disposeObject(_propertyOffVec[j]);
            _propertyOffVec[j] = null;
            j++;
         }
         _propertyOffVec = null;
      }
   }
}
