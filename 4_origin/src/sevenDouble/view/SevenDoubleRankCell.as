package sevenDouble.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import sevenDouble.SevenDoubleControl;
   
   public class SevenDoubleRankCell extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt1:FilterFrameText;
      
      private var _nameTxt2:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _awardCell:BaseCell;
      
      public function SevenDoubleRankCell(param1:int)
      {
         super();
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.cellTxt");
         _rankTxt.text = (param1 + 1).toString();
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.cellTxt");
         _nameTxt1.text = "-------";
         PositionUtils.setPos(_nameTxt1,"sevenDouble.rankView.cellNameTxtPos");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.cellNameTxt");
         _nameTxt2.visible = false;
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("sevenDouble.rankView.cellTxt");
         _rateTxt.text = SevenDoubleControl.instance.rankAddInfo[param1] + "%";
         PositionUtils.setPos(_rateTxt,"sevenDouble.rankView.cellRateTxtPos");
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,30,30);
         _loc3_.graphics.endFill();
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(SevenDoubleControl.instance.sprintAwardInfo[param1]);
         _awardCell = new BaseCell(_loc3_,_loc2_);
         PositionUtils.setPos(_awardCell,"sevenDouble.rankView.cellAwardCellPos");
         addChild(_rankTxt);
         addChild(_nameTxt1);
         addChild(_nameTxt2);
         addChild(_rateTxt);
         addChild(_awardCell);
      }
      
      public function setName(param1:String, param2:int) : void
      {
         _nameTxt2.text = param1;
         if(param2 == 0)
         {
            _nameTxt2.textColor = 16777215;
         }
         else if(param2 == 1)
         {
            _nameTxt2.textColor = 710173;
         }
         else
         {
            _nameTxt2.textColor = 16711680;
         }
         _nameTxt2.visible = true;
         _nameTxt1.visible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _rankTxt = null;
         _nameTxt1 = null;
         _nameTxt2 = null;
         _rateTxt = null;
         _awardCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
