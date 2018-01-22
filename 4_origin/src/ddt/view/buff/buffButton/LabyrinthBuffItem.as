package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import game.view.propertyWaterBuff.PropertyWaterBuffIcon;
   
   public class LabyrinthBuffItem extends Sprite implements Disposeable
   {
       
      
      private var _iconList:Vector.<PropertyWaterBuffIcon>;
      
      private var _buffDesc:Vector.<FilterFrameText>;
      
      public function LabyrinthBuffItem(param1:BuffInfo)
      {
         super();
         _iconList = new Vector.<PropertyWaterBuffIcon>();
         _buffDesc = new Vector.<FilterFrameText>();
         initView(param1);
      }
      
      private function initView(param1:BuffInfo) : void
      {
         var _loc2_:PropertyWaterBuffIcon = ComponentFactory.Instance.creat("game.view.propertyWaterBuff.propertyWaterBuffIcon",[param1]);
         _iconList.push(_loc2_);
         addChild(_loc2_);
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.GesteField");
         var _loc3_:int = (_loc2_.tipData as BuffInfo).getLeftTimeByUnit(86400000) * 24 * 60 + (_loc2_.tipData as BuffInfo).getLeftTimeByUnit(3600000) * 60 + (_loc2_.tipData as BuffInfo).getLeftTimeByUnit(60000);
         _loc4_.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerII",_loc3_);
         _loc4_.x = _loc2_.x + 47;
         _loc4_.y = _loc2_.y + 7;
         _buffDesc.push(_loc4_);
         addChild(_loc4_);
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _iconList;
         for each(var _loc1_ in _iconList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _buffDesc;
         for each(var _loc2_ in _buffDesc)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
