package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.ContentionInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   
   public class ContentionTable extends Sprite implements Disposeable
   {
       
      
      private var _side:int;
      
      private var _vbox:VBox;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function ContentionTable(param1:int)
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         super();
         _side = param1;
         _vbox = new VBox();
         _vbox.spacing = 7;
         _vbox.y = 180;
         addChild(_vbox);
         var _loc5_:int = 0;
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("contention.rank.txt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("contention.name.txt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("contention.score.txt");
         if(_side == 0)
         {
            _loc5_ = 0;
            while(_loc5_ < CityBattleManager.instance.blueList.length)
            {
               _loc4_ = CityBattleManager.instance.blueList[_loc5_];
               _loc3_ = new ContentionItem(_loc4_);
               _loc3_.x = 35;
               _vbox.addChild(_loc3_);
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < CityBattleManager.instance.redList.length)
            {
               _loc4_ = CityBattleManager.instance.redList[_loc5_];
               _loc2_ = new ContentionItem(_loc4_);
               _loc2_.x = 427;
               _vbox.addChild(_loc2_);
               _loc5_++;
            }
         }
         _rankTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.rank");
         _nameTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.name");
         _scoreTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.score");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
   }
}

import cityBattle.data.ContentionInfo;
import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.FilterFrameTextWithTips;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Sprite;

class ContentionItem extends Sprite implements Disposeable
{
    
   
   private var _rankTxt:FilterFrameText;
   
   private var _nameTxt:FilterFrameTextWithTips;
   
   private var _scoreTxt:FilterFrameText;
   
   function ContentionItem(param1:ContentionInfo)
   {
      super();
      _rankTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemRank.txt");
      addChild(_rankTxt);
      _rankTxt.text = String(param1.rank);
      _nameTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemName.txt");
      addChild(_nameTxt);
      _nameTxt.mouseEnabled = true;
      _nameTxt.selectable = false;
      _nameTxt.tipData = param1.server;
      _nameTxt.text = param1.name;
      _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemScore.txt");
      addChild(_scoreTxt);
      _scoreTxt.text = String(param1.socre);
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeObject(_scoreTxt);
      _scoreTxt = null;
      ObjectUtils.disposeObject(_nameTxt);
      _nameTxt = null;
      ObjectUtils.disposeObject(_rankTxt);
      _rankTxt = null;
   }
}
