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
      
      public function ContentionTable(side:int)
      {
         var info:* = null;
         var blueItem:* = null;
         var redItem:* = null;
         super();
         _side = side;
         _vbox = new VBox();
         _vbox.spacing = 7;
         _vbox.y = 180;
         addChild(_vbox);
         var i:int = 0;
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("contention.rank.txt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("contention.name.txt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("contention.score.txt");
         if(_side == 0)
         {
            for(i = 0; i < CityBattleManager.instance.blueList.length; )
            {
               info = CityBattleManager.instance.blueList[i];
               blueItem = new ContentionItem(info);
               blueItem.x = 35;
               _vbox.addChild(blueItem);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < CityBattleManager.instance.redList.length)
            {
               info = CityBattleManager.instance.redList[i];
               redItem = new ContentionItem(info);
               redItem.x = 427;
               _vbox.addChild(redItem);
               i++;
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
   
   function ContentionItem(info:ContentionInfo)
   {
      super();
      _rankTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemRank.txt");
      addChild(_rankTxt);
      _rankTxt.text = String(info.rank);
      _nameTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemName.txt");
      addChild(_nameTxt);
      _nameTxt.mouseEnabled = true;
      _nameTxt.selectable = false;
      _nameTxt.tipData = info.server;
      _nameTxt.text = info.name;
      _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("contention.itemScore.txt");
      addChild(_scoreTxt);
      _scoreTxt.text = String(info.socre);
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
