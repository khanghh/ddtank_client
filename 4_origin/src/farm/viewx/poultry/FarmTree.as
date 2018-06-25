package farm.viewx.poultry
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.PNGHitAreaFactory;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FarmTree extends Sprite implements Disposeable
   {
       
      
      private var _tree:MovieClip;
      
      private var _leaf:MovieClip;
      
      private var _level:FilterFrameText;
      
      private var _levelNum:int;
      
      private var _treeName:FilterFrameText;
      
      private var _area:Sprite;
      
      public function FarmTree()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _tree = ComponentFactory.Instance.creat("asset.farm.tree");
         addChild(_tree);
         _leaf = ComponentFactory.Instance.creat("asset.farm.treeLeaf");
         PositionUtils.setPos(_leaf,"asset.farm.treeLeafPos");
         addChild(_leaf);
         _level = ComponentFactory.Instance.creatComponentByStylename("farm.tree.levelTxt");
         _level.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _levelNum;
         addChild(_level);
         _treeName = ComponentFactory.Instance.creatComponentByStylename("farm.tree.nameTxt");
         _treeName.text = LanguageMgr.GetTranslation("farm.tree.nameText");
         addChild(_treeName);
         _area = PNGHitAreaFactory.drawHitArea(Bitmap(ComponentFactory.Instance.creat("asset.farm.treeArea")).bitmapData);
         _area.buttonMode = true;
         _area.alpha = 0;
         addChild(_area);
      }
      
      private function initEvent() : void
      {
         _area.addEventListener("click",__onTreeClick);
         _area.addEventListener("mouseOver",__onTreeOver);
         _area.addEventListener("mouseOut",__onTreeOut);
         FarmModelController.instance.addEventListener("farmTree_updateTreeLevel",__onUpdateFarmTreeLevel);
      }
      
      protected function __onUpdateFarmTreeLevel(event:FarmEvent) : void
      {
         _levelNum = FarmModelController.instance.model.FarmTreeLevel;
         _level.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _levelNum;
      }
      
      public function setLevel(level:int) : void
      {
         FarmModelController.instance.model.FarmTreeLevel = level;
         _levelNum = level;
         _level.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _levelNum;
      }
      
      protected function __onTreeClick(event:MouseEvent) : void
      {
         var testView:* = null;
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            SoundManager.instance.playButtonSound();
            testView = ComponentFactory.Instance.creatCustomObject("farm.poultry.treeUpgrade");
            LayerManager.Instance.addToLayer(testView,3,true,1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.farmTree.others"));
         }
      }
      
      protected function __onTreeOver(event:MouseEvent) : void
      {
         _tree.gotoAndStop(2);
      }
      
      protected function __onTreeOut(event:MouseEvent) : void
      {
         _tree.gotoAndStop(1);
      }
      
      private function removeEvent() : void
      {
         _area.removeEventListener("click",__onTreeClick);
         _area.removeEventListener("mouseOver",__onTreeOver);
         _area.removeEventListener("mouseOut",__onTreeOut);
         FarmModelController.instance.removeEventListener("farmTree_updateTreeLevel",__onUpdateFarmTreeLevel);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_tree)
         {
            _tree = null;
         }
         if(_leaf)
         {
            _leaf = null;
         }
         if(_treeName)
         {
            _treeName.dispose();
            _treeName = null;
         }
         if(_level)
         {
            _level.dispose();
            _level = null;
         }
      }
   }
}
