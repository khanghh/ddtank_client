package ddt.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HelperHelpBtnCreate implements Disposeable
   {
       
      
      public var helpBtnStyleName:String = "coreii.helpBtn";
      
      public var width:Number = 404;
      
      public var height:Number = 484;
      
      private var _scrollPanel:ListPanel;
      
      private var _content:Sprite;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HelperHelpBtnCreate()
      {
         super();
      }
      
      public function create($parent:Sprite, contentStyleName:String, contentPos:* = null, helpBtnPos:* = null, helpFrameTitle:String = "") : void
      {
         contentPos == null && contentPos;
         helpFrameTitle == null && "AlertDialog.help";
         if(helpBtnPos == null)
         {
            if($parent.parent is Frame)
            {
               helpBtnPos = new Point($parent.parent.width - 100,-37);
            }
            else
            {
               helpBtnPos = new Point(300,-37);
            }
         }
         CoreScrollPanelCell.content = ComponentFactory.Instance.creat(contentStyleName);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("coreii.help.scrollPanel");
         _scrollPanel.factoryStyle = "com.pickgliss.ui.controls.cell.SimpleListCellFactory|ddt.utils.CoreScrollPanelCell,451,451";
         _scrollPanel.vectorListModel.clear();
         _scrollPanel.vectorListModel.appendAll([{}]);
         _scrollPanel.list.updateListView();
         _content = new Sprite();
         _content.addChild(_scrollPanel);
         PositionUtils.setPos(_content,contentPos);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton($parent,helpBtnStyleName,null,helpFrameTitle,_content,width,height) as SimpleBitmapButton;
         PositionUtils.setPos(_helpBtn,helpBtnPos);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_helpBtn);
         ObjectUtils.disposeObject(_scrollPanel);
         ObjectUtils.disposeObject(_content);
         _helpBtn = null;
         _scrollPanel = null;
         _content = null;
      }
   }
}
