//
//  Index.swift
//  
//
//  Created by 史 翔新 on 2022/12/16.
//

import Foundation
import Ink

struct Index {
    
    private let markdownParser = MarkdownParser()
    
    let html: String
    
    init() {
        html = markdownParser.parse(content).html
    }
    
}

private let content = #"""
    # 株式会社ゆめみ iOS 未経験者エンジニア向けコードチェック課題

    ## 概要

    本エンドポイントは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する未経験の方に出す課題のバックエンドです。未経験者の方は[リファクタリングの課題](https://github.com/yumemi-inc/ios-engineer-codecheck)もしくは本課題のいずれかを提出してください。本課題をお選びの方は、下記を詳しく読んだ上で課題に取り組んでください。

    ## アプリ仕様

    「あなたと相性のいい都道府県を占ってあげる！」をテーマに iPhone アプリを作ってください。API 仕様下記の通りです。

    ### API 仕様

    - Base URL:
      
      "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"

    - End Point:
      
      "/my_fortune"

    - HTTP Method:
      
      "POST"

    - HTTP Request Headers:
      
      <table>
        <tr>
          <th>Key</th>
          <th>Value</th>
        </tr>
        <tr>
          <td>"API-Version"</td>
          <td>"v1"</td>
        </tr>
      </table>

      ※"v1"を他の文字列で置き換えると `EndPoint.APIVersion.InitializationError` エラーになります；またこのヘッダーを省略すること自体は可能ですが、将来API仕様が変わる可能性があるため、入れることをお勧めします。

    - HTTP Body:
      
      | Key | Type | Description | Sample Value |
      |:--|:--|:--|:--|
      | "name" | String | 占う人の名前 | "錦木千束" |
      | "birthday" | YearMonthDay（後述） | 占う人の生年月日 | - |
      | "blood_type" | String | 占う人の血液型 | "ab" |
      | "today" | YearMonthDay（後述） | 今日の日付 | - |

      YearMonthDay 型の仕様：
      
      | Key | Type | Description | Sample Value |
      |:--|:--|:--|:--|
      | "year" | Int | 年 | 2004 |
      | "month" | Int | 月 | 9 |
      | "day" | Int | 日 | 23 |

      JSON サンプル
      
      ```json
      {
        "name": "錦木千束",
        "birthday": {
          "year": 2004,
          "month": 9,
          "day": 23
        },
        "blood_type": "ab",
        "today": {
          "year": 2022,
          "month": 7,
          "day": 2
        }
      }
      ```

    - Response Body
      
      | Key | Type | Description | Sample Value |
      |:--|:--|:--|:--|
      | "name" | String | 都道府県の名前 | "福井県" |
      | "capital" | String | 県庁所在地 | "福井市" |
      | "brief" | String | 都道府県の概要 | "福井県（ふくいけん）は、日本の中部地方に位置する県。県庁所在地は福井市。\n北陸地方で最も人口が少ない県である。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』" |

      JSON サンプル
      
      ```json
      {
        "name": "福井県",
        "brief": "福井県（ふくいけん）は、日本の中部地方に位置する県。県庁所在地は福井市。\n北陸地方で最も人口が少ない県である。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』",
        "capital": "福井市"
      }
      ```

    ### 環境

    - IDE：基本最新の安定版（本概要更新時点では Xcode 14.2）
    - Swift：基本最新の安定版（本概要更新時点では Swift 5.7）
    - 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.2）

    ### 動作

    1. ユーザから名前、生年月日及び血液型を入力してもらいます。
    1. 上記のデータと併せて、送信時の日付も一緒に入れて、上記の API に問い合わせてください。
    1. 結果をもらったらその結果を表示してください。

    ### 注意点

    1. 必ず git でプロジェクトを管理し、git ホスティングサービスで提出してください。
      1. ホスティングサービスは GitHub 推奨です。ただし git リポジトリーをそのまま zip 化して提出することは NG です。
      1. git で提出してもらう理由は実装の途中経過を評価するためなので、いわゆるワンコミットの提出や、パッと全部やっつけた雑なコミットが含まれる提出物は評価できないため NG です。必ずコミット粒度を意識して作ってください。もちろんブランチ運用や PR 運用も高評価ポイントになります。
      1. GitHub で提出時に公開リポジトリーで提出したくない場合は、提出時にその旨をキャスターさんに伝えてください、コードチェック担当者の GitHub アカウントを返送しますので該当者に Read 権限を付与してください。
    1. UI の指定はありませんが、UI/UX への考慮も評価ポイントになります。
      1. 特に Dark Mode や横画面など、iOS がデフォルトで利用可能な機能について気をつけてください。例えば Dark Mode で文字が読めないような実装は減点ポイントになります。
    1. 上記の動作さえ満たす限り、機能の追加等はウェルカムです。
      1. 例：占い結果をローカルに保存する、iPad/Mac 対応、などなど。
    1. サードパーティーライブラリーの利用については、オープンソースのものに限り制限しません（むしろ推奨です）。
      1. CocoaPods と Carthage についても利用 OK ですが、SwiftPM の方を推奨します。
    1. SDK は UIKit および SwiftUI どちらでも OK です。
      1. 両方の混在も OK です。

    ## 参考記事

    提出された課題の評価ポイントに関しては、[こちらの記事](https://qiita.com/lovee/items/d76c68341ec3e7beb611)に詳しく書かれてありますので、ぜひご覧ください。
    ライブラリの利用に関しては [こちらの記事](https://qiita.com/ykws/items/b951a2e24ca85013e722)も参照ください。
    """#
