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
      
      public function EscortRankCell(param1:int){super();}
      
      public function setName(param1:String, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
