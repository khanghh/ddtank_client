package gameCommon.view.prop
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PropMaxBtn extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _tipInfo:ToolPropInfo;
      
      public function PropMaxBtn()
      {
         super();
         _tipInfo = new ToolPropInfo();
         _tipInfo.count = 0;
         _tipInfo.shortcutKey = "4";
         _tipInfo.valueType = "max";
         _tipInfo.showTurn = false;
         _tipInfo.showThew = true;
         _tipInfo.showCount = true;
         var info:ItemTemplateInfo = new ItemTemplateInfo();
         info.Name = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.max");
         info.Description = LanguageMgr.GetTranslation("tank.view.common.RoomIIPropTip.maxDetail");
         _tipInfo.info = info;
         ShowTipManager.Instance.addTip(this);
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
      }
      
      public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 20;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 20;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "core.ToolPropTips";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
