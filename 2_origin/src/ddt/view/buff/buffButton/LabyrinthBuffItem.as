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
      
      public function LabyrinthBuffItem(buffInfo:BuffInfo)
      {
         super();
         _iconList = new Vector.<PropertyWaterBuffIcon>();
         _buffDesc = new Vector.<FilterFrameText>();
         initView(buffInfo);
      }
      
      private function initView(buffInfo:BuffInfo) : void
      {
         var icon:PropertyWaterBuffIcon = ComponentFactory.Instance.creat("game.view.propertyWaterBuff.propertyWaterBuffIcon",[buffInfo]);
         _iconList.push(icon);
         addChild(icon);
         var buffDesc:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.info.GesteField");
         var time:int = (icon.tipData as BuffInfo).getLeftTimeByUnit(86400000) * 24 * 60 + (icon.tipData as BuffInfo).getLeftTimeByUnit(3600000) * 60 + (icon.tipData as BuffInfo).getLeftTimeByUnit(60000);
         buffDesc.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerII",time);
         buffDesc.x = icon.x + 47;
         buffDesc.y = icon.y + 7;
         _buffDesc.push(buffDesc);
         addChild(buffDesc);
      }
      
      public function dispose() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _iconList;
         for each(var icon in _iconList)
         {
            ObjectUtils.disposeObject(icon);
            icon = null;
         }
         var _loc6_:int = 0;
         var _loc5_:* = _buffDesc;
         for each(var buffTxt in _buffDesc)
         {
            ObjectUtils.disposeObject(buffTxt);
            buffTxt = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
