/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with this
 * work for additional information regarding copyright ownership. The ASF
 * licenses this file to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package org.apache.hadoop.owl.orm;


import java.util.List;

import org.apache.hadoop.owl.common.OwlException;
import org.apache.hadoop.owl.entity.OwlEntity;
import org.apache.hadoop.owl.entity.PartitionEntity;

/**
 * Class which extends OwlEntityManager for PartitionEntity operations.
 */
public class PartitionEntityManager extends OwlEntityManager<PartitionEntity> {


    /**
     * Instantiates a new partition entity manager.
     * @throws OwlException 
     */
    protected PartitionEntityManager() throws OwlException {
        super(PartitionEntity.class);
    }

    /**
     * Instantiates a new partition entity manager.
     * 
     * @param owlEntityManager
     *            the owl entity manager
     */
    protected PartitionEntityManager(OwlEntityManager<? extends OwlEntity> owlEntityManager) {
        super(PartitionEntity.class, owlEntityManager);
    }


    /* (non-Javadoc)
     * @see org.apache.hadoop.owl.orm.OwlEntityManager#fetchByFilter(java.lang.String)
     */
    @Override
    public List<PartitionEntity> fetchByFilter(String filter) throws OwlException {
        //Call the key query builder to handle filters with key conditions
        KeyQueryBuilder queryBuilder = new KeyQueryBuilder(this, "PartitionEntity");
        String[] query = queryBuilder.buildQuery(filter, "partition");

        //Run the query generated by the query builder
        System.out.println("from " + query[0] + " filter " + query[1]);
        List<PartitionEntity> partitions = fetchByFilter(query[0], query[1]);
        return partitions;
    }

}