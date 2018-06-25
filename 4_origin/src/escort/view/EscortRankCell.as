package escort.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import escort.EscortControl;
   import flash.display.Sprite;
   
   public class EscortRankCell extends Sprite implements Disposeable
   {
       
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt1:FilterFrameText;
      
      private var _nameTxt2:FilterFrameText;
      
      private var _rateTxt:FilterFrameText;
      
      private var _awardCell:BaseCell;
      
      public function EscortRankCell(index:int)
      {
         super();
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("escort.rankView.cellTxt");
         _rankTxt.text = (index + 1).toString();
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("escort.rankView.cellTxt");
         _nameTxt1.text = "-------";
         PositionUtils.setPos(_nameTxt1,"escort.rankView.cellNameTxtPos");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("escort.rankView.cellNameTxt");
         _nameTxt2.visible = false;
         _rateTxt = ComponentFactory.Instance.creatComponentByStylename("escort.rankView.cellTxt");
         _rateTxt.text = EscortControl.instance.rankAddInfo[index] + "%";
         PositionUtils.setPos(_rateTxt,"escort.rankView.cellRateTxtPos");
         var tmpSprite:Sprite = new Sprite();
         tmpSprite.graphics.beginFill(16711680,0);
         tmpSprite.graphics.drawRect(0,0,30,30);
         tmpSprite.graphics.endFill();
         var tmpItemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(EscortControl.instance.sprintAwardInfo[index]);
         _awardCell = new BaseCell(tmpSprite,tmpItemInfo);
         PositionUtils.setPos(_awardCell,"escort.rankView.cellAwardCellPos");
         addChild(_rankTxt);
         addChild(_nameTxt1);
         addChild(_nameTxt2);
         addChild(_rateTxt);
         addChild(_awardCell);
      }
      
      public function setName(name:String, carType:int) : void
      {
         _nameTxt2.text = name;
         if(carType == 0)
         {
            _nameTxt2.textColor = 16777215;
         }
         else if(carType == 1)
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
